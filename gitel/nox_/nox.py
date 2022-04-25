from dbus.mainloop.glib import DBusGMainLoop
import dbus
import dbus.service
from gi.repository import GLib
import subprocess
import lsp
import os
import threading

NOX_DBUS_NAME = "com.lazycat.nox"
NOX_OBJECT_NAME = "/com/lazycat/nox"

class NOX(dbus.service.Object):
    def __init__(self, args):
        dbus.service.Object.__init__(
            self,
            dbus.service.BusName(NOX_DBUS_NAME, bus=dbus.SessionBus()),
            NOX_OBJECT_NAME)

        self.lsp_clients = {}
        self.init_lsp_client(args[0], args[1], args[2])

    @dbus.service.method(NOX_DBUS_NAME, in_signature="sss", out_signature="")
    def init_lsp_client(self, language, command, root_uri):
        if language not in self.lsp_clients or root_uri not in self.lsp_clients[language]:
            p = subprocess.Popen(command, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
            read_pipe = lsp.ReadPipe(p.stderr)
            read_pipe.start()
            json_rpc_endpoint = lsp.JsonRpcEndpoint(p.stdin, p.stdout)
            lsp_endpoint = lsp.LspEndpoint(json_rpc_endpoint)

            lsp_client = lsp.LspClient(lsp_endpoint)
            self.lsp_clients[language] = {}
            self.lsp_clients[language][root_uri] = lsp_client
            workspace_folders = [{'name': 'nox', 'uri': root_uri}]
            lsp_client.server_capabilities = lsp_client.initialize(os.getppid(), None, root_uri, None, lsp.capabilities, "verbose", workspace_folders)

    @dbus.service.method(NOX_DBUS_NAME, in_signature="ssssss", out_signature="")
    def completion(self, language, root_uri, file_path, row, column, last_char):
        # Use sub thread avoid completoin action block input.
        threading.Thread(target=self.get_completion, args=(language, root_uri, file_path, row, column, last_char)).start()

    def get_completion(self, language, root_uri, file_path, row, column, last_char):
        if language in self.lsp_clients and root_uri in self.lsp_clients[language]:
            # Init completion context.
            context = lsp.CompletionContext(lsp.CompletionTriggerKind.Invoked)

            # Change to TriggerCharacter type when last char is trigger char.
            trigger_chars = self.lsp_clients[language][root_uri].server_capabilities["capabilities"]["completionProvider"]["triggerCharacters"]
            is_trigger_char = chr(last_char) in trigger_chars
            if is_trigger_char:
                context = lsp.CompletionContext(lsp.CompletionTriggerKind.TriggerCharacter, ".")

            items = self.lsp_clients[language][root_uri].completion(lsp.TextDocumentItem(file_path, language, 1, ""),
                                                                    lsp.Position(int(row) - 1, int(column)),
                                                                    context).items
            if len(items) > 0:
                candidates = []
                if is_trigger_char:
                    candidates = list(map(lambda i: (i.kind, i.insertText, i.label),
                             filter(lambda x: "{}".format(x.detail) != "builtins", items)))
                else:
                    candidates = list(map(lambda i: (i.kind, i.insertText, i.label), items))
                self.popup_completion_menu(candidates)

    @dbus.service.method(NOX_DBUS_NAME, in_signature="sssss", out_signature="")
    def goto_define(self, language, root_uri, file_path, row, column):
        if language in self.lsp_clients and root_uri in self.lsp_clients[language]:
            location = self.lsp_clients[language][root_uri].definition(
                lsp.TextDocumentItem(file_path, language, 1, ""),
                lsp.Position(int(row) - 1, int(column)))
            if len(location) > 0:
                self.open_define_position(location[0].uri,
                                          location[0].range.start.line + 1,
                                          location[0].range.start.character + 1,
                                          location[0].range.end.line + 1,
                                          location[0].range.end.character + 1)
            else:
                self.echo("Can't found definition at cursor.")

    @dbus.service.signal(NOX_DBUS_NAME)
    def echo(self, message):
        pass

    @dbus.service.signal(NOX_DBUS_NAME)
    def popup_completion_menu(self, items):
        pass

    @dbus.service.signal(NOX_DBUS_NAME)
    def open_define_position(self, file, start_line, start_column, end_line, end_column):
        pass

if __name__ == "__main__":
    import sys
    import signal

    DBusGMainLoop(set_as_default=True) # WARING: only use once in one process

    bus = dbus.SessionBus()
    if bus.request_name(NOX_DBUS_NAME) != dbus.bus.REQUEST_NAME_REPLY_PRIMARY_OWNER:
        print("NOX process is already running.")
    else:
        print("NOX process starting...")

        NOX(sys.argv[1:])

        GLib.MainLoop().run()

        signal.signal(signal.SIGINT, signal.SIG_DFL)
        sys.exit()

;;; gdb-mi-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "gdb-mi" "gdb-mi.el" (0 0 0 0))
;;; Generated autoloads from gdb-mi.el

(autoload 'gdb-create-session "gdb-mi" "\
Create GDB session. This will not associate any target with it." t nil)

(autoload 'gdb-executable "gdb-mi" "\
Start debugging an executable at DEBUGGEE-PATH in the current session.
If no session is available, one is automatically created.

\(fn DEBUGGEE-PATH)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "gdb-mi" '("gdb-")))

;;;***

(provide 'gdb-mi-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; gdb-mi-autoloads.el ends here

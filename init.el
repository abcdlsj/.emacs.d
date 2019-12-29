;;                                    __ _                       _   _
;; _ __ ___  _   _    ___ ___  _ __  / _(_) __ _ _   _ _ __ __ _| |_(_) ___  _ __
;;| '_ ` _ \| | | |  / __/ _ \| '_ \| |_| |/ _` | | | | '__/ _` | __| |/ _ \| '_ \
;;| | | | | | |_| | | (_| (_) | | | |  _| | (_| | |_| | | | (_| | |_| | (_) | | | |
;;|_| |_| |_|\__, |  \___\___/|_| |_|_| |_|\__, |\__,_|_|  \__,_|\__|_|\___/|_| |_|
;;           |___/                         |___/


(add-to-list 'load-path "~/.emacs.d/core/")
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/myel")

(require 'init-packages)
(require 'init-keybindings)
(require 'init-org)
(require 'init-ui)
(require 'init-ivy)
(require 'init-fonts)
(require 'init-custom)
(require 'init-lsp)
(require 'init-sly)
(require 'init-company)
(require 'init-edit)
(require 'init-snippet)

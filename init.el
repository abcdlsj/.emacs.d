;; _ __ ___  _   _    ___ ___  _ __  / _(_) __ _ _   _ _ __ __ _| |_(_) ___  _ __
;;| '_ ` _ \| | | |  / __/ _ \| '_ \| |_| |/ _` | | | | '__/ _` | __| |/ _ \| '_ \
;;| | | | | | |_| | | (_| (_) | | | |  _| | (_| | |_| | | | (_| | |_| | (_) | | | |
;;|_| |_| |_|\__, |  \___\___/|_| |_|_| |_|\__, |\__,_|_|  \__,_|\__|_|\___/|_| |_|
;;           |___/                         |___/

(add-to-list 'load-path "~/.emacs.d/core/")
(add-to-list 'load-path "~/.emacs.d/myel/")
(add-to-list 'load-path "~/.emacs.d/gitel/")

(setq custom-file "~/.emacs.d/core/init-custom.el")

;;init
(require 'init-packages)
(require 'init-optimize)
(require 'init-const)
(require 'init-funcs)
(require 'init-custom)

;;ui
(require 'init-ui)

;;awesome
(require 'init-ivy)
(require 'init-cc)
(require 'init-lsp)
(require 'init-company)
(require 'init-edit)
(require 'init-snippet)
(require 'init-awesome)
(require 'init-lisp)
(require 'init-org)
;;
(require 'init-keybindings)

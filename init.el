;;                                     _ _                       _   _
;; _ __ ___  _   _    ___ ___  _ __  / _(_) __ _ _   _ _ __ __ _| |_(_) ___  _ __
;;| '_ ` _ \| | | |  / __/ _ \| '_ \| |_| |/ _` | | | | '__/ _` | __| |/ _ \| '_ \
;;| | | | | | |_| | | (_| (_) | | | |  _| | (_| | |_| | | | (_| | |_| | (_) | | | |
;;|_| |_| |_|\__, |  \___\___/|_| |_|_| |_|\__, |\__,_|_|  \__,_|\__|_|\___/|_| |_|
;;           |___/                         |___/
;;

(defun update-load-path (&rest _)
  "Update `load-path'."
  (push (expand-file-name "core" user-emacs-directory) load-path)
  (push (expand-file-name "myel" user-emacs-directory) load-path)
  (push (expand-file-name "gitel" user-emacs-directory) load-path))

(advice-add #'package-initialize :after #'update-load-path)
(update-load-path)

(setq custom-file "~/.emacs.d/core/init-custom.el")

;;init
(require 'init-packages)
(require 'init-optimize)
(require 'init-custom)
(require 'init-funcs)
(require 'init-ui)
(require 'init-ivy)
(require 'init-edit)
(require 'init-snippet)
(require 'init-awesome)
(require 'init-lisp)
(require 'init-org)
(require 'init-keybindings)

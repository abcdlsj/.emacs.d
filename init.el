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

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

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
(require 'init-lang)
(require 'init-company)
(require 'init-awesome)
(require 'init-lisp)
(require 'init-org)
(require 'init-keybindings)

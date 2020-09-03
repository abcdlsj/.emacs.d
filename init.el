;; _ __ ___  _   _    ___ ___  _ __  / _(_) __ _ _   _ _ __ __ _| |_(_) ___  _ __
;;| '_ ` _ \| | | |  / __/ _ \| '_ \| |_| |/ _` | | | | '__/ _` | __| |/ _ \| '_ \
;;| | | | | | |_| | | (_| (_) | | | |  _| | (_| | |_| | | | (_| | |_| | (_) | | | |
;;|_| |_| |_|\__, |  \___\___/|_| |_|_| |_|\__, |\__,_|_|  \__,_|\__|_|\___/|_| |_|
;;           |___/                         |___/

(when (version< emacs-version "25.1")
  (error "This requires Emacs 25.1 and above!"))

;; Speed up startup
(defvar centaur-gc-cons-threshold (if (display-graphic-p) 8000000 800000)
  "The default value to use for `gc-cons-threshold'. If you experience freezing,
decrease this. If you experience stuttering, increase this.")

(defvar centaur-gc-cons-upper-limit (if (display-graphic-p) 400000000 100000000)
  "The temporary value for `gc-cons-threshold' to defer it.")

(defvar centaur-gc-timer (run-with-idle-timer 10 t #'garbage-collect)
  "Run garbarge collection when idle 10s.")

(defvar default-file-name-handler-alist file-name-handler-alist)

(setq file-name-handler-alist nil)
(setq gc-cons-threshold centaur-gc-cons-upper-limit)
(add-hook 'emacs-startup-hook
          (lambda ()
            "Restore defalut values after startup."
            (setq file-name-handler-alist default-file-name-handler-alist)
            (setq gc-cons-threshold centaur-gc-cons-threshold)

            ;; GC automatically while unfocusing the frame
            ;; `focus-out-hook' is obsolete since 27.1
            (if (boundp 'after-focus-change-function)
                (add-function :after after-focus-change-function
                  (lambda ()
                    (unless (frame-focus-state)
                      (garbage-collect))))
              (add-hook 'focus-out-hook 'garbage-collect))

            ;; Avoid GCs while using `ivy'/`counsel'/`swiper' and `helm', etc.
            ;; @see http://bling.github.io/blog/2016/01/18/why-are-you-changing-gc-cons-threshold/
            (defun my-minibuffer-setup-hook ()
              (setq gc-cons-threshold centaur-gc-cons-upper-limit))

            (defun my-minibuffer-exit-hook ()
              (setq gc-cons-threshold centaur-gc-cons-threshold))

            (add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
            (add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)))

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

;; 懒猫的好东西，有时间了探究下，自己准备弄一个
;; (add-to-list 'load-path "~/.emacs.d/gitel/nox/")
(add-to-list 'load-path "~/.emacs.d/gitel/valign/")
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
(require 'init-filetree)
(require 'init-kill-ring)
(require 'init-ivy)
(require 'init-edit)
(require 'init-hydra)
(require 'init-company)
;; (require 'init-lsp)

;; (require 'init-nox)
(require 'init-gdb)
(require 'init-snippet)
(require 'init-awesome)
(require 'init-lisp)
(require 'init-lang)
(require 'init-org)
;;key
(require 'init-keybindings)


;; (unless (package-installed-p 'quelpa)
;;    (with-temp-buffer
;;      (url-insert-file-contents "https://github.com/quelpa/quelpa/raw/master/quelpa.el")
;;      (eval-buffer)
;;      (quelpa-self-upgrade)))

;; (quelpa
;; '(quelpa-use-package
;;   :fetcher git
;;   :url "https://github.com/quelpa/quelpa-use-package.git"))
;; (require 'quelpa-use-package)

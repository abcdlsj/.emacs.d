;; Defer garbage collection further back in the startup process
(setq gc-cons-threshold most-positive-fixnum)

;; Package initialize occurs automatically, before `user-init-file' is
;; loaded, but after `early-init-file'. We handle package
;; initialization, so we must prevent Emacs from doing it early!
(setq package-enable-at-startup nil)

;; Inhibit resizing frame
(setq frame-inhibit-implied-resize t)

;; Faster to disable these here (before they've been initialized)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(when (eq system-type 'darwin)
  (push '(ns-transparent-titlebar . t) default-frame-alist))

(defun update-load-path (&rest _)
  "Update `load-path'."
  (push (expand-file-name "core" user-emacs-directory) load-path))

(update-load-path)

(setq custom-file "~/.emacs.d/core/init-custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

(require 'init-ui)
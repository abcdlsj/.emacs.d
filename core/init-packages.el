;;                  _
;; _ __   __ _  ___| | ____ _  __ _  ___
;;| '_ \ / _` |/ __| |/ / _` |/ _` |/ _ \
;;| |_) | (_| | (__|   < (_| | (_| |  __/
;;| .__/ \__,_|\___|_|\_\__,_|\__, |\___|
;;|_|                         |___/
;;
(when (>= emacs-major-version 25)
    (require 'package)
    (package-initialize)
    (setq package-archives '(("gnu"   . "~/media/emacs/gnu")
			     ("melpa" . "~/media/emacs/melpa/")
			     ("org" . 	"~/media/emacs/org/"))))

;; cl - Common Lisp Extension
(require 'cl)

;; Add Packages
(defvar abcdlsj/packages '(
			   ;;base
			   request
			   ;; --- Auto-completion ---
			   company
			   ;; --- Better Editor ---
			   projectile
			   highlight-indent-guides
			   ;;swiper
			   ivy
			   ivy-rich
			   ivy-posframe
			   ;;counsel
			   counsel-projectile
			   ;;swiper
			   all-the-icons-ivy
			   smartparens
			   popwin
			   evil
			   evil-leader
			   evil-collection
			   neotree
			   winum
			   which-key
			   ;;Major Mode
			   markdown-mode
			   lsp-mode
			   ;;lsp
			   company-lsp
			   lsp-ui
			   ccls
			   yasnippet
			   yasnippet-snippets
			   ;;use-package
			   use-package
			   ;;ui
			   ;;perspeen
			   dashboard
			   page-break-lines
			   all-the-icons
			   posframe
			   ;;theme
			   doom-themes
			   doom-modeline
			   solaire-mode
			   base16-theme
			   hide-mode-line
			   ;;lang
			   google-c-style
			   sly
			   sly-quicklisp
			   racket-mode
			   geiser
			   ;;vterm
			   ;;apps
			   gist
			   telega
			   elfeed
			   elfeed-org
			   ;;org
			   ;;org-page
			   ;;mingus
			   ;;workspace
			   persp-mode
			   ;;magit
			   magit
			   ;;read
			   ;;nov
			   ))


;; ...
(setq package-selected-packages abcdlsj/packages)

(defun abcdlsj/packages-installed-p ()
  (loop for pkg in abcdlsj/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (abcdlsj/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg abcdlsj/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

(provide 'init-packages)

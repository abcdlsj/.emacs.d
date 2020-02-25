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
			   company-lsp
			   company-prescient
			   company-box
			   company-tabnine
			   ;; --- Better Editor ---
			   ;;LaTeX
			   auctex
			   ;;pyim
			   avy
			   projectile
			   highlight-indent-guides
			   expand-region
			   ;;swiper
			   ivy
			   ivy-rich
			   ivy-posframe
			   ivy-xref
			   ivy-yasnippet
			   ivy-prescient
			   ivy-fuz
			   ;;counsel
			   amx
			   counsel-projectile
			   ;;swiper
			   ;all-the-icons-ivy
			   smartparens
			   popwin
			   evil
			   evil-leader
			   evil-collection
			   evil-nerd-commenter
			   treemacs
			   treemacs-evil
			   treemacs-projectile
			   treemacs-magit
			   winum
			   which-key
			   ;;key
			   hydra
			   ;;Major Mode
			   markdown-mode
			   lsp-mode
			   ;;lsp
			   lsp-java
			   lsp-haskell
			   dap-mode
			   lsp-ui
			   ccls
			   lsp-python-ms
			   yasnippet
			   yasnippet-snippets
			   auto-yasnippet
			   ;;use-package
			   use-package
			   ;;ui
			   ;;perspeen
			   dashboard
			   page-break-lines
			   all-the-icons
			   posframe
			   cnfonts
			   ;;theme
			   doom-themes
			   doom-modeline
			   solaire-mode
			   base16-theme
			   tao-theme
			   hide-mode-line
			   ;;lang
			   nasm-mode
			   google-c-style
			   sly
			   sly-quicklisp
			   racket-mode
			   ;;vterm
			   eshell-up
			   eshell-did-you-mean
			   ;;apps
			   gist
			   telega
			   ;;elfeed
			   ;;elfeed-org
			   ;;blog
			   ;;org-page
			   org-download
			   ox-hugo
			   org-download
			   ;;mingus
			   ;;workspace
			   persp-mode
			   ;;magit
			   magit
			   ;;read
			   ;;nov
			   benchmark-init
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

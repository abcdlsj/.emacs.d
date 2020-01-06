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
    (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			     ("melpa" . "http://elpa.emacs-china.org/melpa/")
			     ("org" . 	"http://elpa.emacs-china.org/org/"))))

;; cl - Common Lisp Extension
(require 'cl)

;; Add Packages
(defvar abcdlsj/packages '(
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
			   ;;use-package
			   use-package
			   ;;ui
			   dashboard
			   page-break-lines
			   all-the-icons
			   posframe
			   ;;theme
			   doom-modeline
			   base16-theme
			   hide-mode-line
			   ;;lang
			   google-c-style
			   ;;sly
			   ;;sly-quicklisp
			   ;;vterm
			   ;in my GithubPro
			   ;;apps
			   telega
			   elfeed
			   elfeed-org
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

;; 文件末尾
(provide 'init-packages)

;;                  _
;;   _ __   __ _  ___| | ____ _  __ _  ___
;;  | '_ \ / _` |/ __| |/ / _` |/ _` |/ _ \
;;  | |_) | (_| | (__|   < (_| | (_| |  __/
;;  | .__/ \__,_|\___|_|\_\__,_|\__, |\___|
;;  |_|                         |___/
;;

(when (>= emacs-major-version 25)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
						   ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
						   ("org" . 	"http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))
  )

;; cl - Common Lisp Extension
(require 'cl)

;; Add Packages
(defvar abcdlsj/packages '(
						   ;;
						   request
						   exec-path-from-shell
						   ;;
						   company
						   company-prescient
						   company-box
						   ;;
						   auctex
						   ;;
						   avy
						   projectile
						   highlight-indent-guides
						   expand-region
						   ;;
						   ivy
						   ivy-rich
						   all-the-icons-ivy-rich
						   ivy-posframe
						   ivy-xref
						   ivy-yasnippet
						   ivy-prescient
						   ivy-fuz
						   ;;
						   amx
						   counsel-projectile
						   smartparens
						   popwin
						   evil
						   evil-leader
						   evil-collection
						   evil-nerd-commenter
						   winum
						   which-key
						   ;;
						   markdown-mode
						   lsp-mode
						   lsp-ui
						   ccls
						   dap-mode
						   rust-mode
						   go-mode
						   lsp-python-ms
						   yasnippet
						   yasnippet-snippets
						   auto-yasnippet
						   use-package
						   dashboard
						   page-break-lines
						   all-the-icons
						   posframe
						   ;;
						   doom-modeline
						   hide-mode-line
						   modern-cpp-font-lock
						   fontawesome
						   nasm-mode
						   clang-format
						   racket-mode
						   vterm
						   wakatime-mode
						   org-bullets
						   org-download
						   ox-hugo
						   org-download
						   persp-mode
						   magit
						   benchmark-init
						   prescient
						   ;;
						   color-theme-sanityinc-tomorrow
						   spacemacs-theme
						   modus-themes
						   ;;
						   rime
						   ;;
						   neotree
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

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(provide 'init-packages)

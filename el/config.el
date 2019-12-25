(setq recentf-max-menu-item 10)
(setq org-src-fontify-natively t)
(setq inital-scratch-message nil)
(setq inhibit-startup-screen t)
(setq visible-bell t)
(setq ring-bell-function 'ignore)
(setq-default cursor-type 'bar)
;;(global-linum-mode 1)
(setq make-backup-files nil)
(setq auto-save-default nil)  
(electric-pair-mode t)
(delete-selection-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)

;;company-mode
(use-package company
  :config
  (global-company-mode 1))
;evil
(use-package evil
  :config
  (evil-mode t))

(use-package evil-leader
  :config
  (global-evil-leader-mode 1))

(use-package recentf
  :config
  (recentf-mode 1))
;;doom-modline
(use-package doom-modeline
  :config
  (doom-modeline-mode 1))

(use-package winum
  :config
  (winum-mode 1))
;;neotree
(use-package neotree)
;;which-key
(use-package which-key
  :config
  (which-key-mode))
;;all-the-icons
(use-package all-the-icons)
;;popwin
(use-package popwin
  :config
  (popwin-mode 1))

;;smartparens
(use-package smartparens-config)
;;ivy
(use-package ivy
  :config
  (ivy-mode 1)
  (counsel-mode 1))

;;lsp-mode
(use-package lsp-mode
  :config
  (add-hook 'c++-mode-hook #'lsp)
  :commands lsp)
(use-package lsp-ui
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  :commands lsp-ui-mode)
(use-package company-lsp
  :config
  (push 'company-lsp company-backends)
  :commands company-lsp)
(use-package ccls
  :config
  (setq ccls-executable "/usr/bin/ccls")
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
	 (lambda () (require 'ccls) (lsp))))

;;yasnippet
(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package sly
  :config
  (setq inferior-lisp-program "/usr/bin/scheme"))
(use-package sly-quicklisp)
(provide 'config)

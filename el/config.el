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
(global-company-mode 1)
;evil
(require 'evil)
(evil-mode 1)

(require 'evil-leader)
(global-evil-leader-mode 1)

(require 'recentf)
(recentf-mode 1)
;;doom-modline
(require 'doom-modeline)
(doom-modeline-mode 1)

(use-package winum
  :config
  (winum-mode))
;;neotree
(require 'neotree)

;;all-the-icons
(require 'all-the-icons)

;;popwin
(require 'popwin)
(popwin-mode 1)

;;smartparens
(require 'smartparens-config)

;;ivy
(ivy-mode 1)

;;smooth-scrolling
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)

;;hungry-delete
(require 'hungry-delete)
(global-hungry-delete-mode)

;;lsp-mode
(require 'lsp-mode)
;;(add-hook 'c++-mode-hook #'lsp)
(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(require 'company-lsp)
(push 'company-lsp company-backends)
(require 'ccls)
(setq ccls-executable "/usr/bin/ccls")
(use-package lsp-mode :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)

(use-package ccls
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp))))

;;yasnippet
(require 'yasnippet)
(yas-global-mode 1)

(provide 'config)

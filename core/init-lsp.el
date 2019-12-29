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

(provide 'init-lsp)

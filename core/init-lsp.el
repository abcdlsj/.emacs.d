(use-package lsp-mode
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :init
  (setq lsp-keymap-prefix "C-c l")
  (use-package which-key
    :config
    (which-key-mode))
  (use-package lsp-mode :commands lsp)
  (use-package lsp-ui :commands lsp-ui-mode)
  (use-package company-lsp :commands company-lsp)
  (use-package dap-mode)
  (use-package ccls
	:hook ((c-mode c++-mode objc-mode cuda-mode) .
           (lambda () (require 'ccls) (lsp)))))

(provide 'init-lsp)

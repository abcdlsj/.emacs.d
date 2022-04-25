(use-package lsp-mode
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :init
  (setq lsp-keymap-prefix "C-c l")
  (use-package which-key
    :config
    (which-key-mode))
  (use-package lsp-ui :commands lsp-ui-mode)
  (use-package company-lsp :commands company-lsp
	:config
	(push 'company-lsp company-backends))
  (use-package dap-mode)
  :config
  (add-hook 'go-mode-hook #'lsp-deferred)

  ;; Set up before-save hooks to format buffer and add/delete imports.
  ;; Make sure you don't have other gofmt/goimports hooks enabled.
  (defun lsp-go-install-save-hooks ()
	(add-hook 'before-save-hook #'lsp-format-buffer t t)
	(add-hook 'before-save-hook #'lsp-organize-imports t t))
  (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
  )

(provide 'init-lsp)

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

(use-package ivy-xref
  :init
  ;; xref initialization is different in Emacs 27 - there are two different
  ;; variables which can be set rather than just one
  (when (>= emacs-major-version 27)
    (setq xref-show-definitions-function #'ivy-xref-show-defs))
  ;; Necessary in Emacs <27. In Emacs 27 it will affect all xref-based
  ;; commands other than xref-find-definitions (e.g. project-find-regexp)
  ;; as well
  (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))

(provide 'init-lsp)

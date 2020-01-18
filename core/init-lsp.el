;;lsp-mode
(use-package lsp-mode
  :config
  (add-hook 'c++-mode-hook #'lsp)
  :commands lsp)

(use-package lsp-ui
  :config
  (setq lsp-ui-doc-mode t)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  :commands lsp-ui-mode)

(use-package company-lsp
  :config
  (push 'company-lsp company-backends)
  :commands company-lsp)

(use-package ccls
  :defines projectile-project-root-files-top-down-recurring
  :hook ((c-mode c++-mode objc-mode cuda-mode) . (lambda () (require 'ccls)))
  :config
  (setq ccls-executable "usr/local/bin/ccls")
  (with-eval-after-load 'projectile
    (setq projectile-project-root-files-top-down-recurring
          (append '("compile_commands.json"
                    ".ccls")
                  projectile-project-root-files-top-down-recurring))))

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

(use-package lsp-python-ms
  :hook (python-mode . (lambda ()
                          (require 'lsp-python-ms)
                          (lsp))))  ; or lsp-deferred

(provide 'init-lsp)

;;lsp-mode
(use-package lsp-mode
  :hook
  (c++-mode . lsp)
  (c-mode . lsp)
  :commands lsp)

(use-package lsp-ui
  :commands lsp-ui-mode
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  :config
  (setq lsp-ui-peek-enable t)
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-imenu-enable t)
  (setq lsp-ui-flycheck-enable t)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-sideline-ignore-duplicate t))

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

(use-package lsp-java
  :hook (java-mode . (lambda () (require 'lsp-java))))

;; (use-package dap-mode
;;   :after lsp-mode
;;   :config
;;   (dap-mode t)
;;   (dap-ui-mode t))

(use-package dap-mode
  :diminish
  :bind (:map lsp-mode-map
	      ("<f5>" . dap-debug)
	      ("M-<f5>" . dap-hydra))
  :hook ((after-init . dap-mode)
	 (dap-mode . dap-ui-mode)
	 (dap-session-created . (lambda (_args) (dap-hydra)))
	 (dap-stopped . (lambda (_args) (dap-hydra)))

	 (python-mode . (lambda () (require 'dap-python)))
	 (ruby-mode . (lambda () (require 'dap-ruby)))
	 (go-mode . (lambda () (require 'dap-go)))
	 (java-mode . (lambda () (require 'dap-java)))
	 ((c-mode c++-mode objc-mode swift) . (lambda () (require 'dap-lldb)))
	 (php-mode . (lambda () (require 'dap-php)))
	 (elixir-mode . (lambda () (require 'dap-elixir)))
	 ((js-mode js2-mode) . (lambda () (require 'dap-chrome)))
	 (powershell-mode . (lambda () (require 'dap-pwsh)))))

(use-package dap-java :after (lsp-java))

(provide 'init-lsp)

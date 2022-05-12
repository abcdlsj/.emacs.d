;; (use-package lsp-mode
;;   :hook ((lsp-mode . lsp-enable-which-key-integration))
;;   :commands lsp
;;   :init
;;   (setq lsp-keymap-prefix "C-c l")
;;   (use-package which-key
;;     :config
;;     (which-key-mode))
;;   (use-package lsp-ui :commands lsp-ui-mode)
;;   (use-package company-lsp :commands company-lsp
;; 	:config
;; 	(push 'company-lsp company-backends))
;;   (use-package dap-mode)
;;   :config
;;   (add-hook 'go-mode-hook #'lsp-deferred)

;;   ;; Set up before-save hooks to format buffer and add/delete imports.
;;   ;; Make sure you don't have other gofmt/goimports hooks enabled.
;;   (defun lsp-go-install-save-hooks ()
;; 	(add-hook 'before-save-hook #'lsp-format-buffer t t)
;; 	(add-hook 'before-save-hook #'lsp-organize-imports t t))
;;   (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
;;   )

(add-to-list 'load-path "~/.emacs.d/gitel/lsp-bridge")

(require 'lsp-bridge)             ;; load lsp-bridge
(global-corfu-mode)               ;; use corfu as completion ui

(require 'lsp-bridge-orderless)   ;; make lsp-bridge support fuzzy match, optional
(require 'lsp-bridge-icon)        ;; show icon for completion items, optional

;; Enable auto completion in elisp mode.
(dolist (hook (list
               'emacs-lisp-mode-hook
               ))
  (add-hook hook (lambda ()
                   (setq-local corfu-auto t)
                   )))

;; Enable lsp-bridge.
(dolist (hook (list
               'c-mode-hook
               'c++-mode-hook
               'java-mode-hook
               'python-mode-hook
               'ruby-mode-hook
               'rust-mode-hook
               'elixir-mode-hook
               'go-mode-hook
               'haskell-mode-hook
               'haskell-literate-mode-hook
               'dart-mode-hook
               'scala-mode-hook
               'typescript-mode-hook
               'js2-mode-hook
               'js-mode-hook
               'tuareg-mode-hook
               'latex-mode-hook
               'Tex-latex-mode-hook
               'texmode-hook
               'context-mode-hook
               'texinfo-mode-hook
               'bibtex-mode-hook
               ))
  (add-hook hook (lambda ()
                   (setq-local corfu-auto nil)  ;; let lsp-bridge control when popup completion frame
                   (lsp-bridge-mode 1)
				   )))

(provide 'init-lsp)

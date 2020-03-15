;;lsp-mode
(use-package lsp-mode
  :commands lsp)

(use-package lsp-mode
  :defines (lsp-clients-python-library-directories lsp-rust-rls-server-command)
  :commands (lsp-enable-which-key-integration lsp-format-buffer lsp-organize-imports)
  :diminish
  :hook ((prog-mode . (lambda ()
                        (unless (derived-mode-p 'emacs-lisp-mode 'lisp-mode)
                          (lsp-deferred))))
         (lsp-mode . (lambda ()
                       ;; Integrate `which-key'
                       (lsp-enable-which-key-integration)

                       ;; Format and organize imports
                       (unless (apply #'derived-mode-p centaur-lsp-format-on-save-ignore-modes)
                         (add-hook 'before-save-hook #'lsp-format-buffer t t)
                         (add-hook 'before-save-hook #'lsp-organize-imports t t))))
	 (c++-mode . lsp)
	 (c-mode . lsp))

  :bind (:map lsp-mode-map
              ("C-c C-d" . lsp-describe-thing-at-point)
              ([remap xref-find-definitions] . lsp-find-definition)
              ([remap xref-find-references] . lsp-find-references))
  :init
  ;; @see https://github.com/emacs-lsp/lsp-mode#performance
  (setq read-process-output-max (* 1024 1024)) ;; 1MB

  (setq lsp-auto-guess-root nil      ; Detect project root
        lsp-keep-workspace-alive nil ; Auto-kill LSP server
        lsp-enable-indentation nil
        lsp-enable-on-type-formatting nil
        lsp-keymap-prefix "C-c l")

  ;; For `lsp-clients'
  (setq lsp-clients-python-library-directories '("/usr/local/" "/usr/"))
  (unless (executable-find "rls")
    (setq lsp-rust-rls-server-command '("rustup" "run" "stable" "rls"))))

(use-package lsp-ui
  :custom-face
  (lsp-ui-sideline-code-action ((t (:inherit warning))))
  :pretty-hydra
  ((:title (pretty-hydra-title "LSP UI" 'faicon "rocket")
	   :color amaranth :quit-key "q")
   ("Doc"
    (("d e" (lsp-ui-doc-enable (not lsp-ui-doc-mode))
      "enable" :toggle lsp-ui-doc-mode)
     ("d s" (setq lsp-ui-doc-include-signature (not lsp-ui-doc-include-signature))
      "signature" :toggle lsp-ui-doc-include-signature)
     ("d t" (setq lsp-ui-doc-position 'top)
      "top" :toggle (eq lsp-ui-doc-position 'top))
     ("d b" (setq lsp-ui-doc-position 'bottom)
      "bottom" :toggle (eq lsp-ui-doc-position 'bottom))
     ("d p" (setq lsp-ui-doc-position 'at-point)
      "at point" :toggle (eq lsp-ui-doc-position 'at-point))
     ("d f" (setq lsp-ui-doc-alignment 'frame)
      "align frame" :toggle (eq lsp-ui-doc-alignment 'frame))
     ("d w" (setq lsp-ui-doc-alignment 'window)
      "align window" :toggle (eq lsp-ui-doc-alignment 'window)))
    "Sideline"
    (("s e" (lsp-ui-sideline-enable (not lsp-ui-sideline-mode))
      "enable" :toggle lsp-ui-sideline-mode)
     ("s h" (setq lsp-ui-sideline-show-hover (not lsp-ui-sideline-show-hover))
      "hover" :toggle lsp-ui-sideline-show-hover)
     ("s d" (setq lsp-ui-sideline-show-diagnostics (not lsp-ui-sideline-show-diagnostics))
      "diagnostics" :toggle lsp-ui-sideline-show-diagnostics)
     ("s s" (setq lsp-ui-sideline-show-symbol (not lsp-ui-sideline-show-symbol))
      "symbol" :toggle lsp-ui-sideline-show-symbol)
     ("s c" (setq lsp-ui-sideline-show-code-actions (not lsp-ui-sideline-show-code-actions))
      "code actions" :toggle lsp-ui-sideline-show-code-actions)
     ("s i" (setq lsp-ui-sideline-ignore-duplicate (not lsp-ui-sideline-ignore-duplicate))
      "ignore duplicate" :toggle lsp-ui-sideline-ignore-duplicate))))

  :bind (("C-c u" . lsp-ui-imenu)
         :map lsp-ui-mode-map
         ("M-<f6>" . lsp-ui-hydra/body))

  :hook (lsp-mode . lsp-ui-mode)
  :init (setq lsp-ui-doc-enable t
              lsp-ui-doc-use-webkit nil
              lsp-ui-doc-delay 0.2
              lsp-ui-doc-include-signature t
              lsp-ui-doc-position 'at-point
              lsp-ui-doc-border (face-foreground 'default)
              lsp-eldoc-enable-hover nil ; Disable eldoc displays in minibuffer

              lsp-ui-sideline-enable t
              lsp-ui-sideline-show-hover nil
              lsp-ui-sideline-show-diagnostics nil
              lsp-ui-sideline-ignore-duplicate t

              lsp-ui-imenu-enable t
              lsp-ui-imenu-colors `(,(face-foreground 'font-lock-keyword-face)
                                    ,(face-foreground 'font-lock-string-face)
                                    ,(face-foreground 'font-lock-constant-face)
                                    ,(face-foreground 'font-lock-variable-name-face)))
  :config
  (add-to-list 'lsp-ui-doc-frame-parameters '(right-fringe . 8))

  ;; `C-g'to close doc
  (advice-add #'keyboard-quit :before #'lsp-ui-doc-hide)

  ;; Reset `lsp-ui-doc-background' after loading theme
  (add-hook 'after-load-theme-hook
            (lambda ()
              (setq lsp-ui-doc-border (face-foreground 'default))
              (set-face-background 'lsp-ui-doc-background
                                   (face-background 'tooltip)))))

;; Completion
(use-package company-lsp
  :init (setq company-lsp-cache-candidates 'auto)
  :config
  (with-no-warnings
    ;; WORKAROUND: Fix tons of unrelated completion candidates shown
    ;; when a candidate is fulfilled
    ;; @see https://github.com/emacs-lsp/lsp-python-ms/issues/79
    (add-to-list 'company-lsp-filter-candidates '(mspyls))

    (defun my-company-lsp--on-completion (response prefix)
      "Handle completion RESPONSE.
PREFIX is a string of the prefix when the completion is requested.
Return a list of strings as the completion candidates."
      (let* ((incomplete (and (hash-table-p response) (gethash "isIncomplete" response)))
             (items (cond ((hash-table-p response) (gethash "items" response))
                          ((sequencep response) response)))
             (candidates (mapcar (lambda (item)
                                   (company-lsp--make-candidate item prefix))
                                 (lsp--sort-completions items)))
             (server-id (lsp--client-server-id (lsp--workspace-client lsp--cur-workspace)))
             (should-filter (or (eq company-lsp-cache-candidates 'auto)
                                (and (null company-lsp-cache-candidates)
                                     (company-lsp--get-config company-lsp-filter-candidates server-id)))))
        (when (null company-lsp--completion-cache)
          (add-hook 'company-completion-cancelled-hook #'company-lsp--cleanup-cache nil t)
          (add-hook 'company-completion-finished-hook #'company-lsp--cleanup-cache nil t))
        (when (eq company-lsp-cache-candidates 'auto)
          ;; Only cache candidates on auto mode. If it's t company caches the
          ;; candidates for us.
          (company-lsp--cache-put prefix (company-lsp--cache-item-new candidates incomplete)))
        (if should-filter
            (company-lsp--filter-candidates candidates prefix)
          candidates)))
    (advice-add #'company-lsp--on-completion :override #'my-company-lsp--on-completion)))

;; Ivy integration
(use-package lsp-ivy
  :after lsp-mode
  :bind (:map lsp-mode-map
              ([remap xref-find-apropos] . lsp-ivy-workspace-symbol)
              ("C-s-." . lsp-ivy-global-workspace-symbol)))

;; `treemacs' requires 25.2+, so `dap-mode' and `lsp-treemacs' also requires 25.2+
(when emacs/>=25.2p
  ;; Debug
  (use-package dap-mode
    :functions dap-hydra/nil
    :diminish
    :bind (:map lsp-mode-map
		("<f5>" . dap-debug)
		("M-<f5>" . dap-hydra))

    :hook ((after-init . dap-mode)
           (dap-mode . dap-ui-mode)
           (dap-session-created . (lambda (_args) (dap-hydra)))
           (dap-stopped . (lambda (_args) (dap-hydra)))
           (dap-terminated . (lambda (_args) (dap-hydra/nil)))

           (python-mode . (lambda () (require 'dap-python)))
           (ruby-mode . (lambda () (require 'dap-ruby)))
           (go-mode . (lambda () (require 'dap-go)))
           (java-mode . (lambda () (require 'dap-java)))
           ((c-mode c++-mode objc-mode swift-mode) . (lambda () (require 'dap-lldb)))
           (php-mode . (lambda () (require 'dap-php)))
           (elixir-mode . (lambda () (require 'dap-elixir)))
           ((js-mode js2-mode) . (lambda () (require 'dap-chrome)))
           (powershell-mode . (lambda () (require 'dap-pwsh)))))

  ;; `lsp-mode' and `treemacs' integration
  (use-package lsp-treemacs
    :after lsp-mode
    :bind (:map lsp-mode-map
		("C-<f8>" . lsp-treemacs-errors-list)
		("M-<f8>" . lsp-treemacs-symbols)
		("s-<f8>" . lsp-treemacs-java-deps-list))
    :config
    (with-eval-after-load 'ace-window
      (when (boundp 'aw-ignored-buffers)
        (push 'lsp-treemacs-symbols-mode aw-ignored-buffers)
        (push 'lsp-treemacs-java-deps-mode aw-ignored-buffers)))

    (with-no-warnings
      (when (require 'all-the-icons nil t)
        (treemacs-create-theme "centaur-colors"
			       :extends "doom-colors"
			       :config
			       (progn
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "repo" :height 1.0 :v-adjust -0.1 :face 'all-the-icons-blue))
				  :extensions (root))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "tag" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-lblue))
				  :extensions (boolean-data))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-material "settings_input_component" :height 0.95 :v-adjust -0.15 :face 'all-the-icons-orange))
				  :extensions (class))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-material "palette" :height 0.95 :v-adjust -0.15))
				  :extensions (color-palette))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "square-o" :height 0.95 :v-adjust -0.15))
				  :extensions (constant))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "file-text-o" :height 0.95 :v-adjust -0.05))
				  :extensions (document))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-material "storage" :height 0.95 :v-adjust -0.15 :face 'all-the-icons-orange))
				  :extensions (enumerator))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-material "format_align_right" :height 0.95 :v-adjust -0.15 :face 'all-the-icons-lblue))
				  :extensions (enumitem))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "bolt" :height 0.95 :v-adjust -0.05 :face 'all-the-icons-orange))
				  :extensions (event))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "tag" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-lblue))
				  :extensions (field))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "search" :height 0.95 :v-adjust -0.05))
				  :extensions (indexer))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-material "filter_center_focus" :height 0.95 :v-adjust -0.15))
				  :extensions (intellisense-keyword))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-material "share" :height 0.95 :v-adjust -0.15 :face 'all-the-icons-lblue))
				  :extensions (interface))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "tag" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-lblue))
				  :extensions (localvariable))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "cube" :height 0.95 :v-adjust -0.05 :face 'all-the-icons-purple))
				  :extensions (method))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-material "view_module" :height 0.95 :v-adjust -0.15 :face 'all-the-icons-lblue))
				  :extensions (namespace))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-material "format_list_numbered" :height 0.95 :v-adjust -0.15))
				  :extensions (numeric))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-material "control_point" :height 0.95 :v-adjust -0.2))
				  :extensions (operator))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "wrench" :height 0.8 :v-adjust -0.05))
				  :extensions (property))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-material "format_align_center" :height 0.95 :v-adjust -0.15))
				  :extensions (snippet))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "text-width" :height 0.9 :v-adjust -0.05))
				  :extensions (string))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-material "settings_input_component" :height 0.9 :v-adjust -0.15 :face 'all-the-icons-orange))
				  :extensions (structure))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-material "format_align_center" :height 0.95 :v-adjust -0.15))
				  :extensions (template))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "chevron-right" :height 0.75 :v-adjust 0.1 :face 'font-lock-doc-face))
				  :extensions (collapsed) :fallback "+")
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "chevron-down" :height 0.75 :v-adjust 0.1 :face 'font-lock-doc-face))
				  :extensions (expanded) :fallback "-")
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "file-binary" :height 0.9  :v-adjust 0.0 :face 'font-lock-doc-face))
				  :extensions (classfile))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "folder-open" :height 0.9 :v-adjust -0.05 :face 'all-the-icons-blue))
				  :extensions (default-folder-opened))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "file-directory" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-blue))
				  :extensions (default-folder))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "folder-open" :height 0.9 :v-adjust -0.05 :face 'all-the-icons-green))
				  :extensions (default-root-folder-opened))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "file-directory" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-green))
				  :extensions (default-root-folder))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "file-binary" :height 0.9 :v-adjust 0.0 :face 'font-lock-doc-face))
				  :extensions ("class"))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "file-zip" :height 0.9 :v-adjust 0.0 :face 'font-lock-doc-face))
				  :extensions (file-type-jar))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "folder-open" :height 0.9 :v-adjust -0.05 :face 'font-lock-doc-face))
				  :extensions (folder-open))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "file-directory" :height 0.9 :v-adjust 0.0 :face 'font-lock-doc-face))
				  :extensions (folder))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "folder-open" :height 0.9 :v-adjust -0.05 :face 'all-the-icons-orange))
				  :extensions (folder-type-component-opened))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "file-directory" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-orange))
				  :extensions (folder-type-component))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "folder-open" :height 0.9 :v-adjust -0.05 :face 'all-the-icons-green))
				  :extensions (folder-type-library-opened))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "file-directory" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-green))
				  :extensions (folder-type-library))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "folder-open" :height 0.9 :v-adjust -0.05 :face 'all-the-icons-pink))
				  :extensions (folder-type-maven-opened))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "file-directory" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-pink))
				  :extensions (folder-type-maven))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "folder-open" :height 0.9 :v-adjust -0.05 :face 'font-lock-type-face))
				  :extensions (folder-type-package-opened))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "file-directory" :height 0.9 :v-adjust 0.0 :face 'font-lock-type-face))
				  :extensions (folder-type-package))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "plus" :height 0.9 :v-adjust -0.05 :face 'font-lock-doc-face))
				  :extensions (icon-create))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "list" :height 0.9 :v-adjust -0.05 :face 'font-lock-doc-face))
				  :extensions (icon-flat))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-material "share" :height 0.95 :v-adjust -0.2 :face 'all-the-icons-lblue))
				  :extensions (icon-hierarchical))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "link" :height 0.9 :v-adjust -0.05 :face 'font-lock-doc-face))
				  :extensions (icon-link))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "refresh" :height 0.9 :v-adjust -0.05 :face 'font-lock-doc-face))
				  :extensions (icon-refresh))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "chain-broken" :height 0.9 :v-adjust -0.05 :face 'font-lock-doc-face))
				  :extensions (icon-unlink))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-alltheicon "java" :height 1.0 :v-adjust 0.0 :face 'all-the-icons-orange))
				  :extensions (jar))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "book" :height 0.95 :v-adjust -0.05 :face 'all-the-icons-green))
				  :extensions (library))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "folder-open" :face 'all-the-icons-lblue))
				  :extensions (packagefolder-open))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "file-directory" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-lblue))
				  :extensions (packagefolder))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-faicon "archive" :height 0.9 :v-adjust -0.05 :face 'font-lock-doc-face))
				  :extensions (package))
				 (treemacs-create-icon
				  :icon (format "%s " (all-the-icons-octicon "repo" :height 1.0 :v-adjust -0.1 :face 'all-the-icons-blue))
				  :extensions (java-project))))
	(setq lsp-treemacs-theme "centaur-colors")))

(use-package ccls
  :defines projectile-project-root-files-top-down-recurring
  :hook ((c-mode c++-mode objc-mode cuda-mode) . (lambda () (require 'ccls)))
  :config
  (setq ccls-executable "/usr/bin/ccls")
  (setq company-transformers nil
	company-lsp-async t
	company-lsp-cache-candidates nil)
  (setq ccls-sem-highlight-method 'font-lock)
  ;; alternatively, (setq ccls-sem-highlight-method 'overlay)
  (with-eval-after-load 'projectile
    (setq projectile-project-root-files-top-down-recurring
          (append '("compile_commands.json"
                    ".ccls")
                  projectile-project-root-files-top-down-recurring))))

;; (use-package ivy-xref
;;   :init
;;   ;; xref initialization is different in Emacs 27 - there are two different
;;   ;; variables which can be set rather than just one
;;   (when (>= emacs-major-version 27)
;;     (setq xref-show-definitions-function #'ivy-xref-show-defs))
;;   ;; Necessary in Emacs <27. In Emacs 27 it will affect all xref-based
;;   ;; commands other than xref-find-definitions (e.g. project-find-regexp)
;;   ;; as well
;;   (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))

(use-package modern-cpp-font-lock
  :diminish t
  :init (modern-c++-font-lock-global-mode t))

(use-package lsp-python-ms
  :hook (python-mode . (lambda ()
                         (require 'lsp-python-ms)
                         (lsp))))  ; or lsp-deferred

(use-package lsp-java
  :hook (java-mode . (lambda () (require 'lsp-java))))

(use-package dap-java :after (lsp-java))

(use-package lsp-haskell
  :config
  (add-hook 'haskell-mode-hook #'lsp)
  (setq lsp-haskell-process-path-hie "hie-wrapper"))

(provide 'init-lsp)

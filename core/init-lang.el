(use-package clang-format
  :config
  (setq clang-format-style-option "google")
  )

(use-package modern-cpp-font-lock
  :diminish
  :init (modern-c++-font-lock-global-mode t))

(defun asm-mode-setup ()
  (set (make-local-variable 'gofmt-command) "asmfmt")
  (add-hook 'before-save-hook 'gofmt nil t))

(use-package nasm-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.\\(asm\\|s\\)$" . nasm-mode))
  (add-hook 'nasm-mode-hook 'asm-mode-setup))

(use-package rust-mode
  :config
  (add-hook 'rust-mode-hook
			(lambda () (setq indent-tabs-mode nil)))
  (setq rust-format-on-save t)
  (define-key rust-mode-map (kbd "C-c C-c") 'rust-run))

(provide 'init-lang)

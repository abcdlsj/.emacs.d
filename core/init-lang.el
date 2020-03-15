(use-package google-c-style
  :hook
  (c-mode-common-hook . google-set-c-style)
  (c-mode-common-hook . google-make-newline-indent))

;; (require 'clang-format)
;; (setq clang-format-style-option "google")
(use-package modern-cpp-font-lock
    :diminish
    :init (modern-c++-font-lock-global-mode t))

(defun asm-mode-setup ()
  (set (make-local-variable 'gofmt-command) "asmfmt")
  (add-hook 'before-save-hook 'gofmt nil t)
  )

(use-package nasm-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.\\(asm\\|s\\)$" . nasm-mode))
  (add-hook 'nasm-mode-hook 'asm-mode-setup))

(provide 'init-lang)

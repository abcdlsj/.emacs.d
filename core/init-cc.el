(use-package google-c-style
  :hook
  (c-mode-common-hook . google-set-c-style)
  (c-mode-common-hook . google-make-newline-indent))

;; (require 'clang-format)
;; (setq clang-format-style-option "google")

(provide 'init-cc)

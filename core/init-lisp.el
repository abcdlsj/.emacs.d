(use-package geiser
  :hook
  (scheme-mode-hook . geiser-mode)
  :config
  (setq geiser-default-implementation 'racket))

(setq inferior-lisp-program "/usr/bin/clisp")

(provide 'init-lisp)

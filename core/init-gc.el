(use-package gcmh
  :config
  (gcmh-mode 1)
  (setq gcmh-idle-delay 10
		gcmh-high-cons-threshold #x6400000))

(provide 'init-gc)

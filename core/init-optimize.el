;; (use-package benchmark-init
;;     :config
;;     (add-hook 'after-init-hook 'benchmark-init/deactivate))

(use-package gcmh
  :config
  (gcmh-mode 1)
  (setq gcmh-idle-delay 10
		gcmh-high-cons-threshold #x6400000))

(provide 'init-optimize)
;;; init-optimize.el ends here

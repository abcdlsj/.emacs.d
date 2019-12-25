
(use-package base16-theme
  :config
  (load-theme 'base16-default-dark t))
;;company-mode
(global-company-mode 1)

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

(provide 'init-ui)

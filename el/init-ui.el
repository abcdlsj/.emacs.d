
;;DOOM
;; Global settings (defaults)
;;(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;      doom-themes-enable-italic t) ; if nil, italics is universally disabled
;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
;;(load-theme 'doom-one t)
;; Enable flashing mode-line on errors
;;(doom-themes-visual-bell-config)
;; Enable custom neotree theme (all-the-icons must be installed!)
;;(doom-themes-neotree-config)
;; or for treemacs users
;;(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
;;(doom-themes-treemacs-config)
;; Corrects (and improves) org-mode's native fontification.
;;(doom-themes-org-config)
;
(use-package base16-theme
  :config
  (load-theme 'base16-default-dark t))
;;company-mode
(global-company-mode 1)

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

(provide 'init-ui)

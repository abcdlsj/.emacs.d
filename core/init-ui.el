;;(use-package base16-theme
;;  :config
;;  (load-theme 'base16-default-dark t))

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;;(load-theme 'doom-tomorrow-night nil)
  ;(load-theme 'doom-vibrant t)
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  ;;(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  ;;(doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  ;(doom-themes-org-config)
  )

(use-package doom-modeline
  :config
  (doom-modeline-mode 1)
  (setq doom-modeline-height 0.5)
  (set-face-attribute 'mode-line nil :height 110)
  (set-face-attribute 'mode-line-inactive nil :height 110))

(use-package all-the-icons
  :config
  (setq inhibit-compacting-font-caches t))

(use-package hide-mode-line
  :hook (((completion-list-mode completion-in-region-mode) . hide-mode-line-mode)))
;;popwin
(use-package popwin
  :config
  (popwin-mode 1))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (add-to-list 'dashboard-items '(agenda) t)
  (setq dashboard-banner-logo-title "ABCDLSJ!!!"
	dashboard-startup-banner "~/.emacs.d/banner/MIT_GNU_Scheme_Logo_r.png"
	dashboard-center-content t
	dashboard-set-heading-icons t
	dashboard-set-file-icons t
	dashboard-items '((recents  . 10)
			  (bookmarks . 5)
			  (projects . 5)
			  (agenda . 5))))

(if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions #'+my|init-font)
  (+my/better-font))


(provide 'init-ui)

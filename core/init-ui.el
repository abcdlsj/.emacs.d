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
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(global-hl-line-mode 1)
(show-paren-mode 1)
(display-time-mode 1)
;;; Scrolling
(setq hscroll-margin 2
      hscroll-step 1
      scroll-conservatively 10
      scroll-margin 0
      scroll-preserve-screen-position t
      ;; Reduce cursor lag by a tiny bit by not auto-adjusting `window-vscroll'
      ;; for tall lines.
      auto-window-vscroll nil
      ;; mouse
      mouse-wheel-scroll-amount '(5 ((shift) . 2))
      mouse-wheel-progressive-speed nil)  ; don't accelerate scrolling

(set-frame-parameter (selected-frame) 'alpha '(95 100))
(add-to-list 'default-frame-alist (cons 'alpha '(95 100)))

;;(setq frame-title-format "%b  [%I] %f  GNU/Emacs")
(use-package base16-theme
  :config
  (load-theme 'base16-default-dark t))

(use-package doom-modeline
  :config
  (doom-modeline-mode 1))

(use-package all-the-icons)

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

(provide 'init-ui)

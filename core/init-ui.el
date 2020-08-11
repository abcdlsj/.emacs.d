;;; init-ui.el --- description -*- lexical-binding: t; -*-

(unless emacs/>=27p
  (push '(menu-bar-lines . 0) default-frame-alist)
  (push '(tool-bar-lines . 0) default-frame-alist)
  (push '(vertical-scroll-bars) default-frame-alist))

(use-package doom-themes
  :if (display-graphic-p)
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  (load-theme 'doom-vibrant t)
  (doom-themes-visual-bell-config)

  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  ;; (setq doom-themes-treemacs-enable-variable-pitch t)
  ;; (setq doom-variable-pitch-font (font-spec :family "Ubuntu" :size 2))
  ;;(doom-themes-neotree-config)
  ;;(doom-themes-treemacs-config)
  (doom-themes-org-config)
  )

;; (load-theme 'spacemacs-dark)

;; 字体设置
(defun my-font-set()
  (set-face-attribute 'default nil :font
                      (format "%s:pixelsize=%d" "Ubuntu Mono" 26))
  (dolist (charset '(kana han cjk-misc bopomofo))
	(set-fontset-font (frame-parameter nil 'font) charset
					  (font-spec :family "Noto Sans CJK SC" :size 20))))

(when (display-graphic-p)
  (my-font-set))

(load "~/.emacs.d/gitel/valign/valign.el")
(valign-mode)

(use-package doom-modeline
  :config
  (doom-modeline-mode 1)
  (setq doom-modeline-height 1)
  (set-face-attribute 'mode-line nil :height 105)
  (set-face-attribute 'mode-line-inactive nil :height 105)
  )

(use-package all-the-icons
  :if(display-graphic-p))

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
  (setq ;;dashboard-banner-logo-title "RTFSC – Read The F**king Source Code :)!"
   dashboard-banner-logo-title "Recursion or Iteration? That's a question!"
   ;;dashboard-startup-banner "~/.emacs.d/banner/ue-colorful.png"
   ;;dashboard-center-content t
   dashboard-set-heading-icons t
   dashboard-set-file-icons t
   dashboard-items '((recents  . 10)
					 (bookmarks . 5)
					 (projects . 5)
					 (agenda . 5))))

(use-package winum
  :config
  (winum-mode 1))

(provide 'init-ui)

;;; init-ui.el ends here

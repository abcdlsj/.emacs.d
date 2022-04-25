(when (display-graphic-p)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist))

;; Usage
;; item of time-themes-table: ( hours-in-string . theme-name)
(mp-ui/config-time-themes-table '(("6" . sanityinc-tomorrow-bright) ("18" . sanityinc-tomorrow-bright)))
(mp-ui/open-themes-auto-change)

;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   (load-theme 'doom-one t)

;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)
;;   ;; Enable custom neotree theme (all-the-icons must be installed!)
;;   (doom-themes-neotree-config)
;;   ;; or for treemacs users
;;   (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
;;   (doom-themes-treemacs-config)
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))

;; 这是中文
;; this is english
;;
(defun my-font-set()
  (set-face-attribute 'default nil :font
                       (format "%s:pixelsize=%d" "JetBrains Mono" 15))
  (dolist (charset '(kana han cjk-misc bopomofo))
	(set-fontset-font (frame-parameter nil 'font) charset
					  (font-spec :family "PingFang SC" :size 15)))
  )

(when (display-graphic-p)
  (my-font-set))

;; (load "~/.emacs.d/gitel/valign/valign.el")
;; (valign-mode)

;; doom-modeline
(use-package doom-modeline
  :config
  (doom-modeline-mode 1)
  (setq doom-modeline-height 1)
  (set-face-attribute 'mode-line nil :height 150)
  (set-face-attribute 'mode-line-inactive nil :height 150)
)

(use-package all-the-icons
  :if(display-graphic-p))

(use-package hide-mode-line
  :hook (((completion-list-mode completion-in-region-mode) . hide-mode-line-mode)))

;;popwin
(use-package popwin
  :config
  (popwin-mode 1))

(use-package winum
  :config
  (winum-mode 1))

;; file tree
(use-package neotree
  :config
  (setq neo-window-width 32
        neo-create-file-auto-open t
        neo-banner-message nil
        neo-show-updir-line t
        neo-window-fixed-size nil
        neo-vc-integration nil
        neo-mode-line-type 'neotree
        neo-smart-open t
        neo-show-hidden-files t
        neo-mode-line-type 'none
        neo-auto-indent-point t)
  (setq neo-theme (if (display-graphic-p) 'nerd 'arrow))
  (setq neo-hidden-regexp-list '("venv" "\\.pyc$" "~$" "\\.git" "__pycache__" ".DS_Store")))


(provide 'init-ui)

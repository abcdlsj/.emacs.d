(when (display-graphic-p)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist))

;; Usage
;; item of time-themes-table: ( hours-in-string . theme-name)
(mp-ui/config-time-themes-table '(("6" . spacemacs-dark) ("18" . modus-vivendi)))
(mp-ui/open-themes-auto-change)

;; 这是中文
;; this is english
;;
(defun my-font-set()
  (set-face-attribute 'default nil :font
                      (format "%s:pixelsize=%d" "SFMono Nerd Font Mono" 24))
 (dolist (charset '(kana han cjk-misc bopomofo))
	(set-fontset-font (frame-parameter nil 'font) charset
					  (font-spec :family "Sarasa Mono SC Nerd" :size 24))))

(when (display-graphic-p)
  (my-font-set))

;; (load "~/.emacs.d/gitel/valign/valign.el")
;; (valign-mode)

;; doom-modeline
;; (use-package doom-modeline
;;   :config
;;   (doom-modeline-mode 1)
;;   (setq doom-modeline-height 1)
;;   (set-face-attribute 'mode-line nil :height 100)
;;   (set-face-attribute 'mode-line-inactive nil :height 100)
;; )

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

(provide 'init-ui)

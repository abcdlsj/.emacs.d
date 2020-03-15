(use-package counsel
  :diminish ivy-mode counsel-mode

  :bind	(("C-s"   . swiper-isearch)
         ("C-S-s" . swiper-all)

         ("C-c C-r" . ivy-resume)

	 ("C-c i" . counsel-git)
         ("C-c j" . counsel-git-grep)
	 ("C-c k" . counsel-rg)
	 ("C-c f" . counsel-find-library)
	 ("C-c m" . counsel-linux-app)
	 )

  :hook ((after-init . ivy-mode)
         (ivy-mode . counsel-mode))

  :init
  (setq enable-recursive-minibuffers t) ; Allow commands in minibuffers
  (setq search-default-mode #'char-fold-to-regexp)

  (setq ivy-use-selectable-prompt t
        ivy-use-virtual-buffers t    ; Enable bookmarks and recentf
        ivy-height 10
        ivy-fixed-height-minibuffer t
        ivy-count-format "(%d/%d) "
        ivy-on-del-error-function nil
        ivy-initial-inputs-alist nil)

  (setq swiper-action-recenter t))

;; Enhance M-x
(use-package amx
  :init (setq amx-history-length 20))

;;(use-package ivy-posframe
;; :after ivy
;; :config
;; (setq ivy-posframe-display-functions-alist
;;	'((swiper          . ivy-posframe-display-at-window-center)
;;	  (complete-symbol . ivy-posframe-display-at-point)
;;	  (counsel-M-x     . ivy-posframe-display-at-window-center)
;;	  (t               . ivy-posframe-display-at-frame-center)))
;;(ivy-posframe-mode 1))

;;More friendly display transformer for Ivy
(use-package all-the-icons-ivy-rich
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(provide 'init-ivy)

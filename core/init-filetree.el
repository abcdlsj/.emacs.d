;; (when emacs/>=25.2p
;;   ;; A tree layout file explorer
;;   (use-package treemacs
;;     :commands (treemacs-follow-mode
;;                treemacs-filewatch-mode
;;                treemacs-fringe-indicator-mode
;;                treemacs-git-mode)

;;     :bind (("C-c t"       . treemacs)
;;            ;;("C-x 1"     . treemacs-delete-other-windows)
;;            ;;("C-x t 1"   . treemacs-delete-other-windows)
;;            ("C-x t M-t" . treemacs-find-tag)
;;            :map treemacs-mode-map
;;            ([mouse-1]   . treemacs-single-click-expand-action))

;;     :config
;;     (setq treemacs-collapse-dirs           (if treemacs-python-executable 3 0)
;;           treemacs-sorting                 'alphabetic-case-insensitive-desc
;;           treemacs-follow-after-init       t
;;           treemacs-is-never-other-window   t
;;           treemacs-silent-filewatch        t
;;           treemacs-silent-refresh          t
;;           treemacs-width                   20)
;; 	(setq treemacs-indentation-string (propertize " " 'face 'font-lock-comment-face)
;; 		  treemacs-indentation 1)

;;     :config
;;     (treemacs-follow-mode t)
;;     (treemacs-filewatch-mode t)
;;     (pcase (cons (not (null (executable-find "git")))
;;                  (not (null (executable-find "python3"))))
;;       (`(t . t)
;;        (treemacs-git-mode 'deferred))
;;       (`(t . _)
;;        (treemacs-git-mode 'simple)))

;;     (with-eval-after-load 'winum
;;       (define-key winum-keymap (kbd "C-c t") #'treemacs-select-window))

;;     ;; Projectile integration
;;     (use-package treemacs-projectile
;;       :after projectile
;;       :bind (:map projectile-command-map
;; 				  ("h" . treemacs-projectile)))

;;     (use-package treemacs-magit
;;       :after magit
;;       :commands treemacs-magit--schedule-update
;;       :hook ((magit-post-commit
;;               git-commit-post-finish
;;               magit-post-stage
;;               magit-post-unstage)
;;              . treemacs-magit--schedule-update))

;;     (use-package treemacs-evil
;;       :after evil)))

;; (use-package neotree
;;   :config
;;   (global-set-key [f8] 'neotree-toggle))

(provide 'init-filetree)

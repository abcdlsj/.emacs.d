(use-package org
  ;;:init
  ;;(setq org-directory nil)
  ;;(setq org-capture-templates nil)
  :config
  ;;org babel
  (setq org-babel-lisp-eval-fn "sly-eval")
  ;;org-agenda
  (setq org-directory "~/Dropbox/org/")
  (setq org-agenda-files (list "~/Dropbox/org/"))
  (setq org-agenda-file-regexp "\\`[^.].*\\.org\\|.todo\\'")
  (setq org-capture-templates
        '(
          ("m" "Media.Reading.Relaxing.Ideas" entry
           (file+olp+datetree "media.org")
           "* %U - %^{heading} %^g\n%?\n" :tree-type week)
          ("j" "Journal!!!" entry
           (file+olp+datetree "journal.org")
           "* %U - %^{heading} %^g\n%?\n" :tree-type week)
		  ))

  (org-babel-do-load-languages 'org-babel-load-languages '(
                                                           (lisp . t)
                                                           (shell . t)
                                                           (C . t)
														   (java . t)
														   (python . t)
														   (dot . t)
														   (racket . t)
														   (latex . t)
                                                           ))
  ;;org-view
  ;;(setq org-indent-mode 1)
  (setq org-log-done 'time)
  (setq org-image-actual-width '(800))
  ;;(setq org-src-preserve-indentation t)
  (add-hook 'org-mode-hook 'toggle-truncate-lines)
  (setq org-babel-racket-command "/usr/bin/racket")

  (use-package org-bullets
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


  (setq org-todo-keywords '((sequence "TODO(t)" "HAND(h)" "|" "DONE(d)" "CANCELLED(c)")))
  (setf org-todo-keyword-faces '(("TODO" . (:foreground "white" :background "#95A5A6"   :weight bold))
                                 ("HAND" . (:foreground "white" :background "#2E8B57"  :weight bold))
                                 ("DONE" . (:foreground "white" :background "#3498DB" :weight bold))))

  (setq org-highest-priority ?A)
  (setq org-lowest-priority  ?C)
  (setq org-default-priority ?B)
  (setq org-priority-faces
		'((?A . (:background "red" :foreground "white" :weight bold))
		  (?B . (:background "DarkOrange" :foreground "white" :weight bold))
		  (?C . (:background "yellow" :foreground "DarkGreen" :weight bold))
		  ))
  )

;; hugo blog capture
;; (use-package ox-hugo
;;   :after ox)

;; (with-eval-after-load 'org-capture
;;   (defun org-hugo-new-subtree-post-capture-template ()
;;     "Returns `org-capture' template string for new Hugo post.
;; See `org-capture-templates' for more information."
;;     (let* ((title (read-from-minibuffer "Post Title: ")) ;Prompt to enter the post title
;;            (fname (org-hugo-slug title)))
;;       (mapconcat #'identity
;;                  `(
;;                    ,(concat "* TODO " title)
;;                    ":PROPERTIES:"
;;                    ,(concat ":EXPORT_FILE_NAME: " fname)
;;                    ":END:"
;;                    "%?\n")          ;Place the cursor here finally
;;                  "\n")))
;;   (add-to-list 'org-capture-templates
;;                '("h" "Hugo post Blog" entry
;;                  (file "~/Dropbox/org/blog.org")
;;                  (function org-hugo-new-subtree-post-capture-template))))

;; agenda 里面时间块彩色显示
;; From: https://emacs-china.org/t/org-agenda/8679/3
;;
(defun ljg/org-agenda-time-grid-spacing ()
  "Set different line spacing w.r.t. time duration."
  (save-excursion
    (let* ((background (alist-get 'background-mode (frame-parameters)))
           (background-dark-p (string= background "dark"))
           (colors (list "#1ABC9C" "#2ECC71" "#3498DB" "#9966ff"))
           pos
           duration)
      (nconc colors colors)
      (goto-char (point-min))
      (while (setq pos (next-single-property-change (point) 'duration))
        (goto-char pos)
        (when (and (not (equal pos (point-at-eol)))
                   (setq duration (org-get-at-bol 'duration)))
          (let ((line-height (if (< duration 30) 1.0 (+ 0.5 (/ duration 60))))
                (ov (make-overlay (point-at-bol) (1+ (point-at-eol)))))
            (overlay-put ov 'face `(:background ,(car colors)
                                                :foreground
                                                ,(if background-dark-p "black" "white")))
            (setq colors (cdr colors))
            (overlay-put ov 'line-height line-height)
            (overlay-put ov 'line-spacing (1- line-height))))))))

(add-hook 'org-agenda-finalize-hook #'ljg/org-agenda-time-grid-spacing)

(provide 'init-org)

(use-package org
  :init
  (setq org-directory nil)
  (setq org-capture-templates nil)
  :config
  ;;org babel
  (setq org-babel-lisp-eval-fn "sly-eval")
  (require 'ob-go)
  ;;org-agenda
  (setq org-directory "/Users/songjian.li/Workspace/github/Obsidian")
  (setq org-agenda-files (list "/Users/songjian.li/Workspace/github/Obsidian/agenda"))
  (setq org-agenda-file-regexp "\\`[^.].*\\.org\\|.todo\\'")
  (setq org-capture-templates
        '(
          ("t" "Task To Do!" entry
           (file+headline "todo.org" "GTD")
           "* TODO %^{Task Name:}\n%u\n%a\n" :clock-in t :clock-resume t)
          ("n" "Notes!!!" entry
           (file+headline "notes.org" "NOTES")
           "* %U - %^{heading} %^g\n %?\n")
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
  ;;; org-view
  (setq org-indent-mode 1)
  (setq org-log-done 'time)
  (setq org-image-actual-width '(800))
  ;; (setq org-src-preserve-indentation t)
  (add-hook 'org-mode-hook 'toggle-truncate-lines)
  (setq org-babel-racket-command "/usr/bin/racket")

  (use-package org-bullets
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

  (setq org-todo-keywords '((sequence "TODO(t)" "HAND(h)" "|" "DONE(d)" "CANCELLED(c)")))
  (setq org-highest-priority ?A)
  (setq org-lowest-priority  ?C)
  (setq org-default-priority ?B)
  (setq org-priority-faces
		'((?A . (:background "red" :foreground "white" :weight bold))
		  (?B . (:background "DarkOrange" :foreground "white" :weight bold))
		  (?C . (:background "yellow" :foreground "DarkGreen" :weight bold))
		  ))
  )

(use-package ox-hugo
  :after ox)

;; agenda 里面时间块彩色显示
;; From: https://emacs-china.org/t/org-agenda/8679/3
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

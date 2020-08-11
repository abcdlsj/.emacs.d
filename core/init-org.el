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
          ("t" "Task To Do!" plain
           (file "task.org")
           "* TODO %^{Task Name:} \n%?\n")
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
  (setq org-image-actual-width '(400))
  ;;(setq org-src-preserve-indentation t)
  (add-hook 'org-mode-hook 'toggle-truncate-lines)
  (setq org-babel-racket-command "/usr/bin/racket")

  (use-package org-bullets
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


  (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

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

(with-eval-after-load 'org-capture
  (defun org-hugo-new-subtree-post-capture-template ()
    "Returns `org-capture' template string for new Hugo post.
See `org-capture-templates' for more information."
    (let* ((title (read-from-minibuffer "Post Title: ")) ;Prompt to enter the post title
           (fname (org-hugo-slug title)))
      (mapconcat #'identity
                 `(
                   ,(concat "* TODO " title)
                   ":PROPERTIES:"
                   ,(concat ":EXPORT_FILE_NAME: " fname)
                   ":END:"
                   "%?\n")          ;Place the cursor here finally
                 "\n")))
  (add-to-list 'org-capture-templates
               '("h" "Hugo post Blog" entry
                 (file "~/Dropbox/org/blog.org")
                 (function org-hugo-new-subtree-post-capture-template))))

;; (use-package org-brain :ensure t
;;   :init
;;   (setq org-brain-path "~/Dropbox/n/org-brain")
;;   ;; For Evil users
;;   (with-eval-after-load 'evil
;;     (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
;;   :config
;;   (setq org-id-track-globally t)
;;   (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
;;   (add-hook 'before-save-hook #'org-brain-ensure-ids-in-buffer)
;;   (push '("b" "Brain" plain (function org-brain-goto-end)
;;           "* %i%?" :empty-lines 1)
;;         org-capture-templates)
;;   (setq org-brain-visualize-default-choices 'all)
;;   (setq org-brain-title-max-length 12)
;;   (setq org-brain-include-file-entries nil
;;         org-brain-file-entries-use-title nil))


(provide 'init-org)

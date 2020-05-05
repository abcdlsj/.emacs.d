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
           "* TODO %^{Task Name:} \n%^t\n%?\n")
          ("m" "Media.Reading.Relaxing.Ideas" entry
           (file+olp+datetree "media.org")
           "* %U - %^{heading} %^g\n%?\n" :tree-type week)
          ("j" "Journal!!!" entry
           (file+olp+datetree "journal.org")
           "* %U - %^{heading} %^g\n%?\n" :tree-type week)
          ("n" "Notes!!!" plain
           (file "notes.org")
           "* %U - %^{heading} %^g\n%?\n")))

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


;; (use-package org-roam
;;       :hook
;;       (after-init . org-roam-mode)
;;       :custom
;;       (org-roam-directory "~/Dropbox/org/")
;;       :bind (:map org-roam-mode-map
;;               (("C-c n l" . org-roam)
;;                ("C-c n f" . org-roam-find-file)
;;                ("C-c n g" . org-roam-show-graph))
;;               :map org-mode-map
;;               (("C-c n i" . org-roam-insert))))

(provide 'init-org)

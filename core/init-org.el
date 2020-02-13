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
          ("t" "Task To Do!" entry
           (file+headline "task.org" "GTD")
           "* TODO %^{Task Name:}\n%u\n%a\n" :clock-in t :clock-resume t)
         ("r" "Book Reading Task" entry
          (file+headline "task.org" "Reading")
          "* TODO %^{Book Name:}\n%u\n%a\n" :clock-in t :clock-resume t)
         ("j" "Journal!!!" entry
          (file+olp+datetree "journal.org")
          "* %U - %^{heading} %^g\n %?\n" :tree-type week)
         ("n" "Notes!!!" entry
          (file+headline "notes.org" "NOTES")
          "* %U - %^{heading} %^g\n %?\n")))

  (org-babel-do-load-languages 'org-babel-load-languages '(
                                                           (scheme . t)
                                                           (lisp . t)
                                                           (shell . t)
                                                           (C . t)
							   (java . t)
							   (python . t)
                                                           ))
  ;;org-view
  ;(setq org-indent-mode 1)
  (setq org-log-done 'time)
  (setq org-image-actual-width '(400))
  (add-hook 'org-mode-hook 'toggle-truncate-lines)
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

(provide 'init-org)

(use-package ox-hugo
  :after ox)
;; Populates only the EXPORT_FILE_NAME property in the inserted headline.
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
                 "\n"))))

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
          "* %U - %^{heading} %^g\n %?\n")
	 ("h"                ;`org-capture' binding + h
                 "Hugo post"
                 entry
                 ;; It is assumed that below file is present in `org-directory'
                 ;; and that it has a "Blog Ideas" heading. It can even be a
                 ;; symlink pointing to the actual location of all-posts.org!
                 (file+olp "all-posts.org" "Blog Ideas")
                 (function org-hugo-new-subtree-post-capture-template))))

  (org-babel-do-load-languages 'org-babel-load-languages '(
							   (scheme . t)
							   (lisp . t)
							   (shell . t)
							   (C . t)
							   ))
  ;;org-view
  (setq org-indent-mode 1))


;(use-package org-page
;  :load-path "~/.emacs.d/gitel/org-page/"
;  :init
;  (setq op/repository-directory "~/GithubPro/abcdlsj.github.io")
;  (setq op/site-domain "https://abcdlsj.github.io")
;  (setq op/personal-github-link "https://github.com/abcdlsj") ; if you want to show a personal github link
;; (setq op/site-main-title "ABCDLSJ'S WORLD")
;  (setq op/site-sub-title "=========>>享受专注")
;  (setq op/personal-disqus-shortname "abcdlsj")
;  (setq op/repository-org-branch "source")
;  (setq op/repository-html-branch "master")
;  (setq op/theme 'mdo))

(provide 'init-org)

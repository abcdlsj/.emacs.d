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
           (file+headline "~/Dropbox/org/task.org" "GTD")
           "* TODO %^{Task Name:}\n%u\n%a\n" :clock-in t :clock-resume t)
         ("r" "Book Reading Task" entry
          (file+headline "~/Dropbox/org/task.org" "Reading")
          "* TODO %^{Book Name:}\n%u\n%a\n" :clock-in t :clock-resume t)
         ("j" "Journal!!!" entry
          (file+olp+datetree "~/Dropbox/org/journal.org")
          "* %U - %^{heading} %^g\n %?\n" :tree-type week)
         ("n" "Notes!!!" entry
          (file+headline "~/Dropbox/org/notes.org" "NOTES")
          "* %U - %^{heading} %^g\n %?\n"))))

(org-babel-do-load-languages 'org-babel-load-languages '(
							 (scheme . t)
							 (lisp . t)
							 (shell . t)
							 (C . t)
							 ))


(use-package org-page
  :load-path "~/.emacs.d/gitel/org-page/"
  :init
  (setq op/repository-directory "~/GithubPro/abcdlsj.github.io")
  (setq op/site-domain "https://abcdlsj.github.io")
  (setq op/personal-github-link "https://github.com/abcdlsj") ; if you want to show a personal github link
  (setq op/site-main-title "ABCDLSJ'S WORLD")
  (setq op/site-sub-title "=========>>享受专注")
  (setq op/personal-disqus-shortname "abcdlsj")
  (setq op/repository-org-branch "source")
  (setq op/repository-html-branch "master")
  (setq op/theme 'mdo))


(provide 'init-org)

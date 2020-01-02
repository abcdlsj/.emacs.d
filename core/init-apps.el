;;telega
(use-package telega
  :config
  (telega-mode-line-mode 1))


;;sdcv
(use-package sdcv
  :load-path "~/.emacs.d/gitel/"
  :config
  (setq sdcv-say-word-p nil)               ;say word after translation
  (setq sdcv-dictionary-data-dir "~/.stardict/dic/") ;setup directory of stardict dictionary
  (setq sdcv-dictionary-simple-list '())
  (setq sdcv-dictionary-complete-list '()))

;;elfeed
(use-package elfeed)
(use-package elfeed-org
  :after elfeed
  :config
  (setq rmh-elfeed-org-files (list "~/Dropbox/org/elfeed.org"))
  (elfeed-org))

(provide 'init-apps)

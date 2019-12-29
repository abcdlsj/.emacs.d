(eval-when-compile
  (require 'init-const))

(setq uniquify-buffer-name-style 'post-forward-angle-brackets) ; Show path if names are same
(setq adaptive-fill-regexp "[ t]+|[ t]*([0-9]+.|*+)[ t]*")
(setq adaptive-fill-first-line-regexp "^* *$")
(setq delete-by-moving-to-trash t)         ; Deleting files go to OS's trash folder
(setq make-backup-files nil)               ; Forbide to make backup files
(setq auto-save-default nil)               ; Disable auto save
(use-package winum
  :config
  (winum-mode 1))
;;neotree
(use-package neotree)
;;which-key
(use-package which-key
  :config
  (which-key-mode))

(provide 'init-edit)

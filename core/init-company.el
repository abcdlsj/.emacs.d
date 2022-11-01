;; (use-package company
;;   :hook
;;   (after-init . global-company-mode)
;;   :config
;;   (setq company-idle-delay 0)
;;   (setq company-minimum-prefix-length 3)

;;   (add-hook 'emacs-lisp-mode-hook
;;             '(lambda ()
;;                (require 'company-elisp)
;;                (push 'company-elisp company-backends)))
;;   )

(provide 'init-company)

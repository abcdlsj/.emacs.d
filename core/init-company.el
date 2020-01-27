(require 'company)
(require 'company-lsp)
(require 'company-tabnine)

;; workaround for company-transformers
(setq company-tabnine--disable-next-transform nil)
(defun my-company--transform-candidates (func &rest args)
  (if (not company-tabnine--disable-next-transform)
      (apply func args)
    (setq company-tabnine--disable-next-transform nil)
    (car args)))

(defun my-company-tabnine (func &rest args)
  (when (eq (car args) 'candidates)
    (setq company-tabnine--disable-next-transform t))
  (apply func args))

;; Customize company backends.
(setq company-backends (delete 'company-xcode company-backends))
(setq company-backends (delete 'company-bbdb company-backends))
(setq company-backends (delete 'company-eclim company-backends))
(setq company-backends (delete 'company-gtags company-backends))
(setq company-backends (delete 'company-etags company-backends))
(setq company-backends (delete 'company-oddmuse company-backends))
(setq company-backends (delete 'company-yasnippet company-backends))
;; workaround for company-transformers
(setq company-tabnine--disable-next-transform nil)
(defun my-company--transform-candidates (func &rest args)
  (if (not company-tabnine--disable-next-transform)
      (apply func args)
    (setq company-tabnine--disable-next-transform nil)
    (car args)))

(defun my-company-tabnine (func &rest args)
  (when (eq (car args) 'candidates)
    (setq company-tabnine--disable-next-transform t))
  (apply func args))

;; The free version of TabNine is good enough,
;; and below code is recommended that TabNine not always
;; prompt me to purchase a paid version in a large project.
(defadvice company-echo-show (around disable-tabnine-upgrade-message activate)
  (let ((company-message-func (ad-get-arg 0)))
    (when (and company-message-func
               (stringp (funcall company-message-func)))
      (unless (string-match "The free version of TabNine only indexes up to" (funcall company-message-func))
        ad-do-it))))

(advice-add #'company--transform-candidates :around #'my-company--transform-candidates)
(advice-add #'company-tabnine :around #'my-company-tabnine)

(add-to-list 'company-transformers 'company//sort-by-tabnine t)
  ;; `:separate`  使得不同 backend 分开排序
(add-to-list 'company-backends '(company-lsp :with company-tabnine :separate))


(setq company-idle-delay 0.5)
(add-hook 'after-init-hook 'global-company-mode)

(provide 'init-company)

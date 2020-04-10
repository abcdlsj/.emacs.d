(use-package company
  :diminish
  :defines (company-dabbrev-ignore-case company-dabbrev-downcase)
  :commands company-abort
  :bind (("M-/" . company-complete)
         :map company-mode-map
         ("<backtab>" . company-yasnippet)
         :map company-active-map
         ("C-p" . company-select-previous)
         ("C-n" . company-select-next)
         ("<tab>" . company-complete-common-or-cycle)
         ("<backtab>" . my-company-yasnippet)
         :map company-search-map
         ("C-p" . company-select-previous)
         ("C-n" . company-select-next))

  :hook (after-init . global-company-mode)

  :init
  (defun my-company-yasnippet ()
    "Hide the current completeions and show snippets."
    (interactive)
    (company-abort)
    (call-interactively 'company-yasnippet))

  :config
  (setq company-tooltip-align-annotations t
        company-tooltip-limit 12
        company-idle-delay 0.5
        company-echo-delay (if (display-graphic-p) nil 0)
        company-minimum-prefix-length 2
        company-require-match nil
        company-dabbrev-ignore-case nil
        company-dabbrev-downcase nil
        company-global-modes '(not erc-mode message-mode help-mode
                                   gud-mode eshell-mode shell-mode)
        company-frontends '(company-pseudo-tooltip-frontend
                            company-echo-metadata-frontend))

  ;; `yasnippet' integration
  (with-no-warnings
    (defun company-backend-with-yas (backend)
      "Add `yasnippet' to company backend."
      (if (and (listp backend) (member 'company-yasnippet backend))
          backend
        (append (if (consp backend) backend (list backend))
                '(:with company-yasnippet))))

    (defun my-company-enbale-yas (&rest _)
      "Enable `yasnippet' in `company'."
      (setq company-backends (mapcar #'company-backend-with-yas company-backends)))
    ;; Enable in current backends
    (my-company-enbale-yas)
    ;; Support `company-lsp'
    (advice-add #'lsp--auto-configure :after #'my-company-enbale-yas)

    (defun my-company-yasnippet-disable-inline (fun command &optional arg &rest _ignore)
      "Enable yasnippet but disable it inline."
      (if (eq command 'prefix)
          (when-let ((prefix (funcall fun 'prefix)))
            (unless (memq (char-before (- (point) (length prefix))) '(?. ?> ?\())
              prefix))
        (progn
          (when (and arg (not (get-text-property 0 'yas-annotation-patch arg)))
            (let* ((name (get-text-property 0 'yas-annotation arg))
                   (snip (format "%s (Snippet)" name))
                   (len (length arg)))
              (put-text-property 0 len 'yas-annotation snip arg)
              (put-text-property 0 len 'yas-annotation-patch t arg)))
          (funcall fun command arg))))

    (advice-add #'company-yasnippet :around #'my-company-yasnippet-disable-inline))

  ;; Better sorting and filtering
  (use-package company-prescient
    :init (company-prescient-mode 1))

  ;; Icons and quickhelp
  (when emacs/>=26p
    (use-package company-box
      :diminish
      :hook (company-mode . company-box-mode)
      :init (setq company-box-enable-icon t
                  company-box-backends-colors nil
                  company-box-show-single-candidate t
                  company-box-max-candidates 50
                  company-box-doc-delay 0.5)
      :config
      (with-no-warnings
        ;; Highlight `company-common'
        (defun my-company-box--make-line (candidate)
          (-let* (((candidate annotation len-c len-a backend) candidate)
                  (color (company-box--get-color backend))
                  ((c-color a-color i-color s-color) (company-box--resolve-colors color))
                  (icon-string (and company-box--with-icons-p (company-box--add-icon candidate)))
                  (candidate-string (concat (propertize (or company-common "") 'face 'company-tooltip-common)
                                            (substring (propertize candidate 'face 'company-box-candidate)
                                                       (length company-common) nil)))
                  (align-string (when annotation
                                  (concat
                                   " "
                                   (and company-tooltip-align-annotations
                                        (propertize " "
                                                    'display
                                                    `(space :align-to (- right-fringe ,(or len-a 0) 1)))))))
                  (space company-box--space)
                  (icon-p company-box-enable-icon)
                  (annotation-string (and annotation (propertize annotation 'face 'company-box-annotation)))
                  (line (concat (unless (or (and (= space 2) icon-p) (= space 0))
                                  (propertize " " 'display `(space :width ,(if (or (= space 1) (not icon-p)) 1 0.75))))
                                (company-box--apply-color icon-string i-color)
                                (company-box--apply-color candidate-string c-color)
                                align-string
                                (company-box--apply-color annotation-string a-color)))
                  (len (length line)))
            (add-text-properties 0 len (list 'company-box--len (+ len-c len-a)
                                             'company-box--color s-color)
                                 line)
            line))
        (advice-add #'company-box--make-line :override #'my-company-box--make-line)

        ;; Prettify icons
        (defun my-company-box-icons--elisp (candidate)
          (when (derived-mode-p 'emacs-lisp-mode)
            (let ((sym (intern candidate)))
              (cond ((fboundp sym) 'Function)
                    ((featurep sym) 'Module)
                    ((facep sym) 'Color)
                    ((boundp sym) 'Variable)
                    ((symbolp sym) 'Text)
                    (t . nil)))))
        (advice-add #'company-box-icons--elisp :override #'my-company-box-icons--elisp))

        (declare-function all-the-icons-faicon 'all-the-icons)
        (declare-function all-the-icons-material 'all-the-icons)
        (declare-function all-the-icons-octicon 'all-the-icons)
        (setq company-box-icons-all-the-icons
              `((Unknown . ,(all-the-icons-material "find_in_page" :height 0.85 :v-adjust -0.2))
                (Text . ,(all-the-icons-faicon "text-width" :height 0.8 :v-adjust -0.05))
                (Method . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.05 :face 'all-the-icons-purple))
                (Function . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.05 :face 'all-the-icons-purple))
                (Constructor . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.05 :face 'all-the-icons-purple))
                (Field . ,(all-the-icons-octicon "tag" :height 0.8 :v-adjust 0 :face 'all-the-icons-lblue))
                (Variable . ,(all-the-icons-octicon "tag" :height 0.8 :v-adjust 0 :face 'all-the-icons-lblue))
                (Class . ,(all-the-icons-material "settings_input_component" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-orange))
                (Interface . ,(all-the-icons-material "share" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-lblue))
                (Module . ,(all-the-icons-material "view_module" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-lblue))
                (Property . ,(all-the-icons-faicon "wrench" :height 0.8 :v-adjust -0.05))
                (Unit . ,(all-the-icons-material "settings_system_daydream" :height 0.85 :v-adjust -0.2))
                (Value . ,(all-the-icons-material "format_align_right" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-lblue))
                (Enum . ,(all-the-icons-material "storage" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-orange))
                (Keyword . ,(all-the-icons-material "filter_center_focus" :height 0.85 :v-adjust -0.2))
                (Snippet . ,(all-the-icons-material "format_align_center" :height 0.85 :v-adjust -0.2))
                (Color . ,(all-the-icons-material "palette" :height 0.85 :v-adjust -0.2))
                (File . ,(all-the-icons-faicon "file-o" :height 0.85 :v-adjust -0.05))
                (Reference . ,(all-the-icons-material "collections_bookmark" :height 0.85 :v-adjust -0.2))
                (Folder . ,(all-the-icons-faicon "folder-open" :height 0.85 :v-adjust -0.05))
                (EnumMember . ,(all-the-icons-material "format_align_right" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-lblue))
                (Constant . ,(all-the-icons-faicon "square-o" :height 0.85 :v-adjust -0.1))
                (Struct . ,(all-the-icons-material "settings_input_component" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-orange))
                (Event . ,(all-the-icons-octicon "zap" :height 0.8 :v-adjust 0 :face 'all-the-icons-orange))
                (Operator . ,(all-the-icons-material "control_point" :height 0.85 :v-adjust -0.2))
                (TypeParameter . ,(all-the-icons-faicon "arrows" :height 0.8 :v-adjust -0.05))
                (Template . ,(all-the-icons-material "format_align_left" :height 0.85 :v-adjust -0.2)))
              company-box-icons-alist 'company-box-icons-all-the-icons)))

  ;; Popup documentation for completion candidates
  (when (and (not emacs/>=26p) (display-graphic-p))
    (use-package company-quickhelp
      :defines company-quickhelp-delay
      :bind (:map company-active-map
		  ([remap company-show-doc-buffer] . company-quickhelp-manual-begin))
      :hook (global-company-mode . company-quickhelp-mode)
      :init (setq company-quickhelp-delay 0.5))))

  ;; ;; workaround for company-transformers
  ;; (setq company-tabnine--disable-next-transform nil)
  ;; (defun my-company--transform-candidates (func &rest args)
  ;;   (if (not company-tabnine--disable-next-transform)
  ;; 	(apply func args)
  ;;     (setq company-tabnine--disable-next-transform nil)
  ;;     (car args)))

  ;; (defun my-company-tabnine (func &rest args)
  ;;   (when (eq (car args) 'candidates)
  ;;     (setq company-tabnine--disable-next-transform t))
  ;;   (apply func args))

  ;; (setq company-tabnine--disable-next-transform nil)
  ;; (defun my-company--transform-candidates (func &rest args)
  ;;   (if (not company-tabnine--disable-next-transform)
  ;; 	(apply func args)
  ;;     (setq company-tabnine--disable-next-transform nil)
  ;;     (car args)))

  ;; (defun my-company-tabnine (func &rest args)
  ;;   (when (eq (car args) 'candidates)
  ;;     (setq company-tabnine--disable-next-transform t))
  ;;   (apply func args))

  ;; ;; The free version of TabNine is good enough,
  ;; ;; and below code is recommended that TabNine not always
  ;; ;; prompt me to purchase a paid version in a large project.
  ;; (defadvice company-echo-show (around disable-tabnine-upgrade-message activate)
  ;;   (let ((company-message-func (ad-get-arg 0)))
  ;;     (when (and company-message-func
  ;; 		 (stringp (funcall company-message-func)))
  ;; 	(unless (string-match "The free version of TabNine only indexes up to" (funcall company-message-func))
  ;;         ad-do-it))))

  ;; (add-to-list 'company-backends #'company-tabnine)
  ;; (advice-add #'company--transform-candidates :around #'my-company--transform-candidates)
  ;; (advice-add #'company-tabnine :around #'my-company-tabnine)
  ;; (add-to-list 'company-backends '(company-lsp :with company-yasnippet))
  ;; (add-to-list 'company-transformers 'company//sort-by-tabnine t)
  ;; ;; `:separate`  使得不同 backend 分开排序
  ;; (add-to-list 'company-backends '(company-lsp :with company-tabnine :separate))

(provide 'init-company)

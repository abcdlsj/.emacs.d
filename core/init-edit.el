(eval-when-compile
  (require 'init-const))

;;which-key
(use-package which-key
  :config
  (which-key-mode))

;;auto-pair

;(electric-pair-mode t)
;(setq electric-pair-pairs '(
;                            (?\" . ?\")
;                            (?\` . ?\`)
;                            (?\( . ?\))
;                            (?\{ . ?\})
;                            ))
;(setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)

(require 'awesome-pair)
(dolist (hook (list
               'c-mode-common-hook
               'c-mode-hook
               'c++-mode-hook
               'java-mode-hook
               'haskell-mode-hook
               'emacs-lisp-mode-hook
               'lisp-interaction-mode-hook
               'lisp-mode-hook
               'maxima-mode-hook
               'ielm-mode-hook
               'sh-mode-hook
               'makefile-gmake-mode-hook
               'php-mode-hook
               'python-mode-hook
               'js-mode-hook
               'go-mode-hook
               'qml-mode-hook
               'jade-mode-hook
               'css-mode-hook
               'ruby-mode-hook
               'coffee-mode-hook
               'rust-mode-hook
               'qmake-mode-hook
               'lua-mode-hook
               'swift-mode-hook
               'minibuffer-inactive-mode-hook
	       'scheme-mode-hook
	       'racket-mode-hook
               ))
  (add-hook hook '(lambda () (awesome-pair-mode 1))))

(define-key awesome-pair-mode-map (kbd "(") 'awesome-pair-open-round)
(define-key awesome-pair-mode-map (kbd "[") 'awesome-pair-open-bracket)
(define-key awesome-pair-mode-map (kbd "{") 'awesome-pair-open-curly)
(define-key awesome-pair-mode-map (kbd ")") 'awesome-pair-close-round)
(define-key awesome-pair-mode-map (kbd "]") 'awesome-pair-close-bracket)
(define-key awesome-pair-mode-map (kbd "}") 'awesome-pair-close-curly)
(define-key awesome-pair-mode-map (kbd "$") 'awesome-pair-match-paren)
(define-key awesome-pair-mode-map (kbd "\"") 'awesome-pair-double-quote)
(define-key awesome-pair-mode-map (kbd "C-k o") 'awesome-pair-backward-delete)
(define-key awesome-pair-mode-map (kbd "C-k k") 'awesome-pair-kill)
(define-key awesome-pair-mode-map (kbd "C-k \"") 'awesome-pair-wrap-double-quote)
(define-key awesome-pair-mode-map (kbd "C-k [") 'awesome-pair-wrap-bracket)
(define-key awesome-pair-mode-map (kbd "C-k {") 'awesome-pair-wrap-curly)
(define-key awesome-pair-mode-map (kbd "C-k (") 'awesome-pair-wrap-round)
(define-key awesome-pair-mode-map (kbd "C-k )") 'Awesome-pair-unwrap)
(define-key awesome-pair-mode-map (kbd "C-k p") 'awesome-pair-jump-right)
(define-key awesome-pair-mode-map (kbd "C-k n") 'awesome-pair-jump-left)
(define-key awesome-pair-mode-map (kbd "C-k :") 'awesome-pair-jump-out-pair-and-newline)

;; (use-package highlight-indent-guides
;;   :config
;;   (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;;   (setq highlight-indent-guides-method 'character))

(use-package expand-region
  :defer 1
  :bind (("C-=" . er/expand-region)))

(use-package avy)

(eval-when-compile
  (require 'init-const))

;; Manage and navigate projects
(use-package projectile
  :diminish
  :bind (:map projectile-mode-map
         ("C-c p" . projectile-command-map))
  :hook (after-init . projectile-mode)
  :init
  (setq projectile-mode-line-prefix ""
        projectile-sort-order 'recentf
        projectile-use-git-grep t
	projectile-git-submodule-command nil
        projectile-completion-system 'ivy)
  :config
  ;; (projectile-update-mode-line)         ; Update mode-line at the first time

  ;; Use the faster searcher to handle project files: ripgrep `rg'.
  (when (and (not (executable-find "fd"))
             (executable-find "rg"))
    (setq projectile-generic-command
          (let ((rg-cmd ""))
            (dolist (dir projectile-globally-ignored-directories)
              (setq rg-cmd (format "%s --glob '!%s'" rg-cmd dir)))
            (concat "rg -0 --files --color=never --hidden" rg-cmd)))))

;;python format
(require 'blacken)

(load "auctex.el" nil t t)
(load "preview.el" nil t t)

(add-hook 'LaTeX-mode-hook
	  (lambda()
	    (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
	    (setq TeX-command-default "XeLaTeX")
	    (setq TeX-save-querynil )
	    (setq TeX-show-compilation t)
	    ))

;; (require 'auto-save)
;; (auto-save-enable)

;; (setq auto-save-silent t)   ; quietly save
;; (setq auto-save-delete-trailing-whitespace t)  ; automatically delete spaces at the end of the line when saving

(provide 'init-edit)

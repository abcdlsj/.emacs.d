(eval-when-compile
  (require 'init-const))

(use-package winum
  :config
  (winum-mode 1))

(use-package treemacs
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "C-c t") #'treemacs-select-window)))

(use-package treemacs)

(use-package treemacs-evil
  :after treemacs evil)

(use-package treemacs-projectile
  :after treemacs projectile)

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
               ))
  (add-hook hook '(lambda () (awesome-pair-mode 1))))

(use-package highlight-indent-guides
  :config
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-method 'character))

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
        ;;projectile-use-git-grep t
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

(provide 'init-edit)

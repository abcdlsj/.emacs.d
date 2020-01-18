(eval-when-compile
  (require 'init-const))

(use-package winum
  :config
  (winum-mode 1))

;;neotree
(use-package neotree)

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

(provide 'init-edit)

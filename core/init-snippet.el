(use-package yasnippet
:config
(yas-global-mode 1))

(use-package doom-snippets
  :load-path "~/.emacs.d/gitel/doom-snippets/"
  :after yasnippet)

(provide 'init-snippet)

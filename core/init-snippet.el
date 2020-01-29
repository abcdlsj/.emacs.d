(use-package yasnippet
  :diminish yas-minor-mode
  :hook (after-init . yas-global-mode)
  :config (use-package doom-snippets
	    :load-path "~/.emacs.d/gitel/doom-snippets/"
	    :after yasnippet))

(use-package ivy-yasnippet
  :bind ("C-c C-y" . ivy-yasnippet)
  :after yasnippet)
(provide 'init-snippet)

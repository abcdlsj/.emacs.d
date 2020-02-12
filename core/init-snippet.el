(use-package yasnippet
  :diminish yas-minor-mode
  :hook (after-init . yas-global-mode)
  :config (use-package yasnippet-snippets
	    :after yasnippet))

(use-package ivy-yasnippet
  :after yasnippet)

(provide 'init-snippet)

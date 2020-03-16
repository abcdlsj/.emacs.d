(use-package yasnippet
  :init (yas-global-mode 1)
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  )

(use-package yasnippet-snippets
  :after yasnippet)
(use-package ivy-yasnippet
  :after yasnippet)

(provide 'init-snippet)

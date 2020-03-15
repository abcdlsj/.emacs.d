(use-package yasnippet
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode)

  (use-package yasnippet-snippets
    :after yasnippet))

;; (use-package ivy-yasnippet
;;   :after yasnippet)

(provide 'init-snippet)

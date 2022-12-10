(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(add-hook 'kill-emacs-query-functions
          'custom-prompt-customize-unsaved-options)

(set-frame-name (concat "EMACS - " (buffer-name)))

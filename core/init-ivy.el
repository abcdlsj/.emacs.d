(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  ;; enable this if you want `swiper' to use it
  (setq search-default-mode #'char-fold-to-regexp))

(use-package ivy-posframe
  :after ivy
  :config
  (setq ivy-posframe-display-functions-alist
	'((swiper          . ivy-posframe-display-at-window-center)
	  (complete-symbol . ivy-posframe-display-at-point)
	  (counsel-M-x     . ivy-posframe-display-at-window-center)
	  (t               . ivy-posframe-display-at-frame-center)))
  (ivy-posframe-mode 1))

(use-package ivy-rich
  :config
  (ivy-rich-mode 1)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))

(provide 'init-ivy)

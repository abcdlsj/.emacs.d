;;telega
(use-package telega
  :config
  (telega-mode-line-mode 1))

;;vterm
;; (use-package vterm
;;   :load-path "~/.emacs.d/gitel/emacs-libvterm")

;;sdcv
(use-package sdcv
  :load-path "~/.emacs.d/gitel/"
  :config
  (setq sdcv-say-word-p nil)               ;say word after translation
  (setq sdcv-dictionary-data-dir "~/.stardict/dic/") ;setup directory of stardict dictionary
  (setq sdcv-dictionary-simple-list '())
  (setq sdcv-dictionary-complete-list '()))

;;nov
;;(use-package nov
;;  :config
;;  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))


;;company-english-helper
(require 'company-english-helper)

(require 'ivy-baidu-fanyi-sug)

;;magit
;;(use-package magit)

;; (use-package eaf
;;   :load-path "~/.emacs.d/gitel/emacs-application-framework"
;;   :custom
;;   (eaf-find-alternate-file-in-dired t)
;;   :config
;;   (eaf-bind-key scroll_up "RET" eaf-pdf-viewer-keybinding)
;;   (eaf-bind-key scroll_down_page "DEL" eaf-pdf-viewer-keybinding)
;;   (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
;;   (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
;;   (eaf-bind-key take_photo "p" eaf-camera-keybinding)
;;   (setq eaf-grip-token "1f9f6b249d2a08255b89875aebc025fd596805c8")
;;   (eaf-setq eaf-browser-default-zoom  "1.25"))

(require 'aweshell)

(provide 'init-awesome)

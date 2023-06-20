;; 这是中文
;; this is english
;;
(defun my-font-set()
  (set-face-attribute 'default nil :font
                       (format "%s:pixelsize=%d" "Hack" 15))
  (dolist (charset '(kana han cjk-misc bopomofo))
	(set-fontset-font (frame-parameter nil 'font) charset
					  (font-spec :family "PingFang SC" :size 15)))
  )

(when (display-graphic-p)
  (my-font-set))

(setq ring-bell-function 'ignore)

(provide 'init-ui)

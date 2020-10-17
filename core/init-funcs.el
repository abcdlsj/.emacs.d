;; ====================================Themes automatically change =====================================
;;timer for automatically changing themes
(setq mp-ui--interval-timer nil)

;;table is used to save (time themes) pair for automatically changing themes
;;time should be a string. themes should be a variant , not symbos.
(setq mp-ui--time-themes-table nil)

(defun mp-ui/config-time-themes-table (tt)
  "Set time . themes table for time-themes-table."
  (setq mp-ui--time-themes-table
		;; sort firstly, get-themes-according require a sorted table.
		(sort tt (lambda (x y) (< (string-to-number (car x)) (string-to-number (car y)))))
        )
  )

(defun mp-ui/get-themes-according (hour-string)
  "This function return the theme according to hour-string.
Value of hour-string should be between 1 and 24(including)."
  (catch 'break
    (let (
          (now-time (string-to-number hour-string))
          ;; init current-themes to the themes of final item
          (correct-themes (cdr (car (last mp-ui--time-themes-table))))
          (loop-list mp-ui--time-themes-table)
          )

      ;; loop to set correct themes to correct-themes
      (while loop-list
        (let ((v (car loop-list)))
          (let ((v-time (string-to-number (car v))) (v-themes (cdr v)))
            (if (< now-time v-time)
                (throw 'break correct-themes)  ; t
              (setq correct-themes v-themes) ; nil
              )))
        (setq loop-list (cdr loop-list))
        )
      ;; This is returned for value of hour-string is bigger than or equal to car of final item
      (throw 'break correct-themes) ; t
      ))
  )

(defun mp-ui/check-time-and-modify-theme ()
  "This function will get the theme of now according to time-table-themes,
then check whether emacs should to modify theme, if so, modify it."
  (let ((new-theme (mp-ui/get-themes-according (format-time-string "%H"))))
    (load-theme new-theme)
    )
  )

(defun mp-ui/open-themes-auto-change ()
  "Start to automatically change themes."
  (interactive)
  (mp-ui/check-time-and-modify-theme)
  (setq
   mp-ui--interval-timer (run-at-time 3600 3600 'mp-ui/check-time-and-modify-theme))
  (message "themes auto change open.")
  )

(defun mp-ui/close-themes-auto-change ()
  "Close automatically change themes."
  )

;; Usage
;; item of time-themes-table: ( hours-in-string . theme-name)
;; 6:00 - 17::00 use light, 17:00 - 24:00 use dark, 24:00 - 6:00 use light
;; you could add more items.
;; (mp-ui/config-time-themes-table '(("6" . spacemacs-light) ("18" . spacemacs-dark)))
;; (mp-ui/open-themes-auto-change)

(provide 'init-funcs)

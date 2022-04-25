;;; Require
(require 'dbus)
(require 'cl-lib)

;;; Code:

(defcustom nox-buffer-name "*nox*"
  "Name of Nox buffer."
  :type 'string)

(defcustom nox-python-command "python3"
  "The Python interpreter used to run nox.py."
  :type 'string)

(defcustom nox-completion-delay 0.2
  "The completion delay after change buffer, in millisecond."
  :type 'float)

(defcustom nox-flash-line-delay .3
  "How many seconds to flash `nox-font-lock-flash' after navigation.

Setting this to nil or 0 will turn off the indicator."
  :type 'number)

(defface nox-font-lock-flash
  '((t (:inherit highlight)))
  "Face to flash the current line.")

(defvar nox-python-file (expand-file-name "nox.py" (file-name-directory load-file-name)))

(defvar nox--process nil)

(defvar nox--last-buffer nil)

(defvar nox--completion-item-kind-alist
  '(
    (1 . "text")
    (2 . "method")
    (3 . "fn")
    (4 . "constructor")
    (5 . "field")
    (6 . "var")
    (7 . "class")
    (8 . "interface")
    (9 . "module")
    (10 . "property")
    (11 . "unit")
    (12 . "value")
    (13 . "enum")
    (14 . "keyword")
    (15 . "snippet")
    (16 . "color")
    (17 . "file")
    (18 . "reference")
    (19 . "folder")
    (20 . "enum member")
    (21 . "constant")
    (22 . "struct")
    (23 . "event")
    (24 . "operator")
    (25 . "type parameter")
    ))

(defvar nox--language-alist
  '(
    ("py" . ("python" . "python -m pyls"))
    ))

(defvar company-nox-keywords '())

(defun nox-start-server ()
  "Start Nox server and init LSP client."
  (interactive)
  (if (process-live-p nox--process)
      ;; If nox server process has start, try init LSP client once.
      (unless (boundp 'nox-init-lsp-client)
        (nox-call "init_lsp_client" nox-language-id nox-language-cmd nox-root-uri)
        (setq-local nox-init-lsp-client t))
    ;; Otherwise start server process and init LSP client.
    (setq nox--process (apply #'start-process nox-buffer-name nox-buffer-name
                              nox-python-command
                              (list nox-python-file nox-language-id nox-language-cmd nox-root-uri)))
    (message "Start Nox server...")
    ))

(defun nox-get-root-uri ()
  "Get project uri or current file path.
Use for init LSP client."
  (let ((project (project-current)))
    (concat "file://"
            (if project
                (expand-file-name (cdr project))
              (buffer-file-name)
              ))))

(defun nox-stop-server ()
  "Stop Nox process."
  (interactive)
  ;; Delete Nox buffer.
  (when (get-buffer nox-buffer-name)
    (kill-buffer nox-buffer-name))
  ;; Kill Nox process.
  (if (process-live-p nox--process)
      (progn
        (delete-process nox--process)
        (message "Nox process terminated."))
    (message "Nox process has terminated.")))

(defun nox-mode-enable ()
  "Enable nox mode."
  (interactive)
  ;; Init local variables.
  (unless (boundp 'nox-root-uri)
    (setq-local nox-root-uri (nox-get-root-uri)))
  (unless (boundp 'nox-language-id)
    (let ((language-info (cdr (assoc (file-name-extension (buffer-file-name)) nox--language-alist))))
      (setq-local nox-language-id (car language-info))
      (setq-local nox-language-cmd (cdr language-info))))

  ;; Start Nox server.
  (nox-start-server)

  ;; Add file change hook.
  (add-hook 'post-command-hook #'nox-monitor-file-change t t))

(defun nox-monitor-file-change ()
  "When user modify file, add some delay and try completion."
  (when (buffer-modified-p)
    (setq-local nox-change-id (nox-current-time))
    (run-with-timer nox-completion-delay nil 'nox-try-completion)))

(defun nox-try-completion ()
  "Try send completion request to LSP server."
  ;; If user type so fast than completion delay, cancel send completion request to LSP.
  (when (< (+ nox-change-id (* nox-completion-delay 1000)) (nox-current-time))
    (nox-call "completion" nox-language-id nox-root-uri (concat "file://" (buffer-file-name)) (format-mode-line "%l") (format-mode-line "%c") (char-before))
    ))

(defun nox-goto-define ()
  (interactive)
  (nox-call "goto_define" nox-language-id nox-root-uri (concat "file://" (buffer-file-name)) (format-mode-line "%l") (format-mode-line "%c")))

(defun nox-current-time ()
  "Get current time, use to compare completion delay, in millisecond."
  (* 1000 (time-to-seconds (current-time))))

(defun nox-call (method &rest args)
  "Call NOX Python process using `dbus-call-method' with METHOD and ARGS."
  (apply #'dbus-call-method
         :session                   ; use the session (not system) bus
         "com.lazycat.nox"          ; service name
         "/com/lazycat/nox"         ; path name
         "com.lazycat.nox"          ; interface name
         method
         :timeout 1000000
         args))

(dbus-register-signal
 :session "com.lazycat.nox" "/com/lazycat/nox"
 "com.lazycat.nox" "echo"
 #'message)

(dbus-register-signal
 :session "com.lazycat.nox" "/com/lazycat/nox"
 "com.lazycat.nox" "popup_completion_menu"
 #'nox--popup-completion-menu)

(defun nox--popup-completion-menu (items)
  "Update completion candidates from popup_completion_menu signal."
  (setq company-nox-keywords items))

(dbus-register-signal
 :session "com.lazycat.nox" "/com/lazycat/nox"
 "com.lazycat.nox" "open_define_position"
 #'nox--open-define-position)

(defun nox--open-define-position (file start-row start-column end-row end-column)
  (let ((pulse-iterations 1)
        (pulse-delay nox-flash-line-delay)
        start end)
    ;; Open file.
    (find-file file)

    ;; Find end position.
    (save-excursion
      (goto-line end-row)
      (nox-jump-to-column end-column)
      (setq end (point)))

    ;; Jump to start position.
    (goto-line start-row)
    (nox-jump-to-column start-column)
    (setq start (point))

    ;; Flash match line.
    (pulse-momentary-highlight-region start end 'nox-font-lock-flash)

    ;; Message to user.
    (message "Jump to the definition of %s" (symbol-at-point))
    ))

(defun nox-jump-to-column (column)
  "This function use for jump to correct column positions in multi-byte strings.
Such as, mixed string of Chinese and English.

Function `move-to-column' can't handle mixed string of Chinese and English correctly."
  (let ((scan-column 0)
        (first-char-point (point)))

    (while (> column scan-column)
      (forward-char 1)
      (setq scan-column (string-bytes (buffer-substring first-char-point (point)))))

    (backward-char 1)))

(defun company-nox--make-candidate (candidate)
  "Bulid candidate line."
  (let ((text (nth 1 candidate))
        (meta (format "[%s] %s"
                      (cdr (assoc (nth 0 candidate) nox--completion-item-kind-alist))
                      (nth 2 candidate))))
    (propertize text 'meta meta)))

(defun company-nox--candidates (prefix)
  "Filter candidates with user input prefix."
  (let (res)
    (dolist (item company-nox-keywords)
      (when (string-prefix-p prefix (nth 1 item))
        (push (company-nox--make-candidate item) res)))
    res))

(defun company-nox--meta (candidate)
  (format "%s of %s"
          (get-text-property 0 'meta candidate)
          (substring-no-properties candidate)))

(defun company-nox--annotation (candidate)
  "Format candidate annotation."
  (format " %s" (get-text-property 0 'meta candidate)))

(defun company-nox (command &optional arg &rest ignored)
  "Company backend for Nox."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-nox))
    (prefix (company-grab-symbol-cons "\\.\\|->" 2))
    (candidates (company-nox--candidates arg))
    (annotation (company-nox--annotation arg))
    (meta (company-nox--meta arg))))

(defun nox--monitor-buffer-change ()
  "Start Nox mode if user switch to file that support in `nox--language-alist'."
  (unless (eq (current-buffer)
              nox--last-buffer)
    ;; Try start node.
    (nox-try-start)

    ;; Switch buffer clean nox completion candidates.
    (setq company-nox-keywords '())

    ;; Record last buffer.
    (setq nox--last-buffer (current-buffer))))

(add-hook 'post-command-hook #'nox--monitor-buffer-change)

(defun nox-try-start ()
  (when (and (buffer-file-name)
             (assoc (file-name-extension (buffer-file-name)) nox--language-alist))
    (nox-mode-enable)))

(nox-try-start)

(setq company-tooltip-align-annotations t)

(provide 'nox)
;;; nox.el ends here

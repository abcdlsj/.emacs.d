;; _              _     _           _ _                 
;;| | _____ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___ 
;;| |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
;;|   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
;;|_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
;;|___/                             |___/
;; 

;evil
(use-package evil
  :config
  (evil-mode t))

(use-package evil-leader
  :config
  (global-evil-leader-mode 1))

(global-set-key (kbd "M-m") 'set-mark-command)
;;open private config
(defun open-private-dire()
  (interactive)
  (directory-files))
;;evil-leader
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "ff" 'find-file
  "fw" 'find-file-other-window
  ;;"fp" 'open-private-config
  "fr" 'recentf-open-files
  "sb" 'switch-to-buffer
  "kb" 'kill-buffer
  "eb" 'eval-buffer
  "nt" 'neotree-toggle
  ;;"/" 'xref-find-definitions
  "0" 'winum-select-window-0
  "1" 'winum-select-window-1
  "2" 'winum-select-window-2
  "3" 'winum-select-window-3
  "4" 'winum-select-window-4
  "X" 'counsel-org-capture
  "oA" 'counsel-org-agenda
  "vt" 'vterm-other-window)
(provide 'init-keybindings)

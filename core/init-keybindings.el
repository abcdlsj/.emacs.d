;; _              _     _           _ _
;;| | _____ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___
;;| |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
;;|   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
;;|_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
;;|___/                             |___/
;;

;evil
(use-package evil
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-leader
  :after evil
  :config
  (global-evil-leader-mode 1))
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))
(global-set-key (kbd "M-m") 'set-mark-command)
(global-set-key (kbd "M--") 'shell-command)
;;evil-leader
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "ff" 'find-file
  "fw" 'find-file-other-window
  ;;"fp" 'open-private-config
  "fr" 'recentf-open-files
  "bs" 'switch-to-buffer
  "bk" 'kill-buffer
  "be" 'eval-buffer
  "nt" 'neotree-toggle
  ;;"/" 'xref-find-definitions
  "0" 'winum-select-window-0
  "1" 'winum-select-window-1
  "2" 'winum-select-window-2
  "3" 'winum-select-window-3
  "4" 'winum-select-window-4
  "oc" 'counsel-org-capture
  "oa" 'org-agenda
  "vt" 'vterm-other-window)

(provide 'init-keybindings)

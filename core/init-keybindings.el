;; _              _     _           _ _
;;| | _____ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___
;;| |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
;;|   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
;;|_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
;;|___/                             |___/
;;
;evil

(global-set-key (kbd "M-m") 'set-mark-command)
(global-set-key (kbd "M--") 'shell-command)
(global-set-key (kbd "C-c e") 'company-english-helper-search)
(global-set-key (kbd "M-q") "ESC")
(global-unset-key (kbd "C-SPC"))
(global-unset-key (kbd "C-n"))
;; evil-leader
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
 "ll" 'evil-avy-goto-line
 "lc" 'evil-avy-goto-char
 "ff" 'counsel-find-file
 "fw" 'find-file-other-window
 "fl" 'counsel-library
 "fr" 'counsel-buffer-or-recentf
 "fd" 'delete-file
 "fe" 'eaf-open
 ;; counsel
 "ca" 'counsel-ag
 "cz" 'counsel-fzf
 "cy" 'ivy-yasnippet
 "bs" 'counsel-switch-buffer
 "bk" 'kill-buffer
 "be" 'eval-buffer

 "xd" 'xref-find-definitions
 "xf" 'xref-find-references

 ;; "0" 'treemacs-select-window
 "1" 'winum-select-window-1
 "2" 'winum-select-window-2
 "3" 'winum-select-window-3
 "4" 'winum-select-window-4
 "oc" 'counsel-org-capture
 "oa" 'org-agenda
 ;; ivy
 "fy" 'ivy-baidu-fanyi-suggest
 "mc" 'comment-region
 "mu" 'uncomment-region
 "v" 'vterm
 ;; neotree
 "nt" 'neotree-toggle
 )

(provide 'init-keybindings)

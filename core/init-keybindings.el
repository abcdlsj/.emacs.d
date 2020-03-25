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
(global-unset-key (kbd "C-SPC"))
(global-unset-key (kbd "C-n"))
;;evil-leader
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "ll" 'evil-avy-goto-line
  "lc" 'evil-avy-goto-char
  "ff" 'counsel-find-file
  "fw" 'find-file-other-window
  "fl" 'counsel-library
  ;;"fp" 'open-private-config
  "fr" 'counsel-buffer-or-recentf
  "fd" 'delete-file
  "fe" 'eaf-open
  ;;counsel
  "ca" 'counsel-ag
  "cz" 'counsel-fzf
  "cy" 'ivy-yasnippet
  "bs" 'switch-to-buffer
  "bk" 'kill-buffer
  "be" 'eval-buffer
  "xd" 'xref-find-definitions
  "xf" 'xref-find-references
  "0" 'treemacs-select-window
  "1" 'winum-select-window-1
  "2" 'winum-select-window-2
  "3" 'winum-select-window-3
  "4" 'winum-select-window-4
  "oc" 'counsel-org-capture
  "oa" 'org-agenda
  ;;ivy
  "is" 'ivy-baidu-fanyi-suggest
  ;;"ia" 'ivy-yasnippet
  ;; "qd" 'awesome-tab-forward-tab
  ;; "qa" 'awesome-tab-backward-tab
  ;; "qw" 'awesome-tab-forward-group
  ;; "qs" 'awesome-tab-backward-group
  )

(global-set-key
 (kbd "C-c C-n")
 (defhydra hydra-move
   (:body-pre (next-line))
   "move"
   ("n" next-line)
   ("p" previous-line)
   ("f" forward-char)
   ("b" backward-char)
   ("a" beginning-of-line)
   ("e" move-end-of-line)
   ("v" scroll-up-command)
   ;; Converting M-v to V here by analogy.
   ("V" scroll-down-command)
   ("l" recenter-top-bottom)))

(provide 'init-keybindings)

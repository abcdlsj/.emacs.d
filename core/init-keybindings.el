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
(global-set-key (kbd "C-c e") 'company-english-helper-search)
;;evil-leader
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "ff" 'counsel-find-file
  "fw" 'find-file-other-window
  ;;"fp" 'open-private-config
  "fr" 'counsel-recentf
  "fd" 'delete-file
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
  "vt" 'vterm-other-window
  ;;company
  ;;ivy
  "is" 'ivy-baidu-fanyi-suggest
  "/" 'xref-find-definitions-at-mouse
  )

(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(provide 'init-keybindings)

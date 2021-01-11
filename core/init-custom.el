(when (<= emacs-major-version 27)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

(global-hl-line-mode t)
(show-paren-mode t)

;;; Scrolling
(setq hscroll-margin 2
      hscroll-step 1
      scroll-conservatively 10
      scroll-margin 0
      scroll-preserve-screen-position t
      ;; Reduce cursor lag by a tiny bit by not auto-adjusting `window-vscroll'
      ;; for tall lines.
      auto-window-vscroll nil
      ;; mouse
      mouse-wheel-scroll-amount '(5 ((shift) . 2))
      mouse-wheel-progressive-speed nil)  ; don't accelerate scrolling

;; (set-frame-parameter (selected-frame) 'alpha '(85 100))
;; (add-to-list 'default-frame-alist (cons 'alpha '(95 100)))

(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

(use-package recentf
  :ensure nil
  :hook (after-init . recentf-mode)
  :init (setq recentf-max-saved-items 300
              recentf-exclude
              '("\\.?cache" ".cask" "url" "COMMIT_EDITMSG\\'" "bookmarks"
                "\\.\\(?:gz\\|gif\\|svg\\|png\\|jpe?g\\|bmp\\|xpm\\)$"
                "\\.?ido\\.last$" "\\.revive$" "/G?TAGS$" "/.elfeed/"
                "^/tmp/" "^/var/folders/.+$" ; "^/ssh:"
                (lambda (file) (file-in-directory-p file package-user-dir))))
  :config (push (expand-file-name recentf-save-file) recentf-exclude))

(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode)
  :init (setq enable-recursive-minibuffers t ; Allow commands in minibuffers
              history-length 1000
              savehist-additional-variables '(mark-ring
                                              global-mark-ring
                                              search-ring
                                              regexp-search-ring
                                              extended-command-history)
              savehist-autosave-interval 300))

(use-package time
  :ensure nil
  :unless (display-graphic-p)
  :hook (after-init . display-time-mode)
  :init (setq display-time-24hr-format t
              display-time-day-and-date t))

(setq system-time-locale "C")
(format-time-string "%Y-%m-%d %a")

(use-package simple
  :ensure nil
  :hook ((window-setup . size-indication-mode)
         ((prog-mode markdown-mode conf-mode) . enable-trailing-whitespace))
  :init
  (setq column-number-mode t
        line-number-mode t
        ;; kill-whole-line t               ; Kill line including '\n'
        line-move-visual nil
        track-eol t                     ; Keep cursor at end of lines. Require line-move-visual is nil.
        set-mark-command-repeat-pop t)  ; Repeating C-SPC after popping mark pops it again

  ;; Visualize TAB, (HARD) SPACE, NEWLINE
  (setq-default show-trailing-whitespace nil) ; Don't show trailing whitespace by default
  (defun enable-trailing-whitespace ()
    "Show trailing spaces and delete on saving."
    (setq show-trailing-whitespace t)
    (add-hook 'before-save-hook #'delete-trailing-whitespace nil t)))

(setq visible-bell nil
      inhibit-compacting-font-caches t  ; Don’t compact font caches during GC.
      delete-by-moving-to-trash t       ; Deleting files go to OS's trash folder
      make-backup-files nil             ; Forbide to make backup files
      auto-save-default nil             ; Disable auto save

      inhibit-startup-screen t
      org-startup-indented t

      ;; after copy Ctrl+c in Linux X11, you can paste by `yank' in emacs
      x-select-enable-clipboard t
      ;; after mouse selection in X11, you can paste by `yank' in emacs
      x-select-enable-primary t

      uniquify-buffer-name-style 'post-forward-angle-brackets ; Show path if names are same
      adaptive-fill-regexp "[ t]+|[ t]*([0-9]+.|*+)[ t]*"
      adaptive-fill-first-line-regexp "^* *$"
      sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*"
      sentence-end-double-space nil)

(fset 'yes-or-no-p 'y-or-n-p)
(setq user-full-name "abcdlsj")
(setq user-mail-address "lisongjianshuai@gmail.com")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   (vector "#002451" "#ff9da4" "#d1f1a9" "#ffeead" "#bbdaff" "#ebbbff" "#99ffff" "#ffffff"))
 '(ansi-term-color-vector
   [unspecified "#1d1f21" "#cc342b" "#198844" "#fba922" "#3971ed" "#a36ac7" "#3971ed" "#c5c8c6"] t)
 '(beacon-color "#ff9da4")
 '(custom-safe-themes
   '("dbf58130f89f49aca831812c8df2452d7126388f6cc34a42666c691f88a8be3e" "4ce515d79ef94f3b7651c8e2a7c7d81814b9ca911eb2a16955f45f4555faf524" "18c5ec0e4d1723dbeadb65d17112f077529fd24261cb8cd4ceee145e6a6f4cd1" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "37144b437478e4c235824f0e94afa740ee2c7d16952e69ac3c5ed4352209eefb" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "79278310dd6cacf2d2f491063c4ab8b129fee2a498e4c25912ddaa6c3c5b621e" "99ea831ca79a916f1bd789de366b639d09811501e8c092c85b2cb7d697777f93" "2cdc13ef8c76a22daa0f46370011f54e79bae00d5736340a5ddfe656a767fddf" "cb96a06ed8f47b07c014e8637bd0fd0e6c555364171504680ac41930cfe5e11e" "fa3bdd59ea708164e7821574822ab82a3c51e262d419df941f26d64d015c90ee" "e1ef2d5b8091f4953fe17b4ca3dd143d476c106e221d92ded38614266cea3c8b" "1d50bd38eed63d8de5fcfce37c4bb2f660a02d3dff9cbfd807a309db671ff1af" "615123f602c56139c8170c153208406bf467804785007cdc11ba73d18c3a248b" "f9cae16fd084c64bf0a9de797ef9caedc9ff4d463dd0288c30a3f89ecf36ca7e" "285efd6352377e0e3b68c71ab12c43d2b72072f64d436584f9159a58c4ff545a" "229c5cf9c9bd4012be621d271320036c69a14758f70e60385e87880b46d60780" "51956e440cec75ba7e4cff6c79f4f8c884a50b220e78e5e05145386f5b381f7b" "c83c095dd01cde64b631fb0fe5980587deec3834dc55144a6e78ff91ebc80b19" "730a87ed3dc2bf318f3ea3626ce21fb054cd3a1471dcd59c81a4071df02cb601" "d5f8099d98174116cba9912fe2a0c3196a7cd405d12fa6b9375c55fc510988b5" "7f791f743870983b9bb90c8285e1e0ba1bf1ea6e9c9a02c60335899ba20f3c94" "7d708f0168f54b90fc91692811263c995bebb9f68b8b7525d0e2200da9bc903c" "fc0f72847d02407567d1b57aae74038f97cb103d4c2c897c474fdb925f41c173" "0ad7f1c71fd0289f7549f0454c9b12005eddf9b76b7ead32a24d9cb1d16cbcbd" "6231254e74298a1cf8a5fee7ca64352943de4b495e615c449e9bb27e2ccae709" "3e3a1caddeee4a73789ff10ba90b8394f4cd3f3788892577d7ded188e05d78f4" "845103fcb9b091b0958171653a4413ccfad35552bc39697d448941bcbe5a660d" "6bacece4cf10ea7dd5eae5bfc1019888f0cb62059ff905f37b33eec145a6a430" "1526aeed166165811eefd9a6f9176061ec3d121ba39500af2048073bea80911e" "a339f231e63aab2a17740e5b3965469e8c0b85eccdfb1f9dbd58a30bdad8562b" "3577ee091e1d318c49889574a31175970472f6f182a9789f1a3e9e4513641d86" "7c4cfa4eb784539d6e09ecc118428cd8125d6aa3053d8e8413f31a7293d43169" "c968804189e0fc963c641f5c9ad64bca431d41af2fb7e1d01a2a6666376f819c" "7a2ac0611ded83cdd60fc4de55ba57d36600eae261f55a551b380606345ee922" "542e6fee85eea8e47243a5647358c344111aa9c04510394720a3108803c8ddd1" "ef403aa0588ca64e05269a7a5df03a5259a00303ef6dfbd2519a9b81e4bce95c" "840db7f67ce92c39deb38f38fbc5a990b8f89b0f47b77b96d98e4bf400ee590a" "5a39d2a29906ab273f7900a2ae843e9aa29ed5d205873e1199af4c9ec921aaab" "44961a9303c92926740fc4121829c32abca38ba3a91897a4eab2aa3b7634bed4" "1025e775a6d93981454680ddef169b6c51cc14cea8cb02d1872f9d3ce7a1da66" "808b47c5c5583b5e439d8532da736b5e6b0552f6e89f8dafaab5631aace601dd" "e1498b2416922aa561076edc5c9b0ad7b34d8ff849f335c13364c8f4276904f0" "264b639ee1d01cd81f6ab49a63b6354d902c7f7ed17ecf6e8c2bd5eb6d8ca09c" "146061a7ceea4ccc75d975a3bb41432382f656c50b9989c7dc1a7bb6952f6eb4" default))
 '(eaf-find-alternate-file-in-dired t t)
 '(electric-indent-mode t)
 '(evil-collection-setup-minibuffer t)
 '(fci-rule-color "#003f8e")
 '(flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
 '(frame-background-mode 'dark)
 '(hl-todo-keyword-faces
   '(("TODO" . "#dc752f")
	 ("NEXT" . "#dc752f")
	 ("THEM" . "#2d9574")
	 ("PROG" . "#4f97d7")
	 ("OKAY" . "#4f97d7")
	 ("DONT" . "#f2241f")
	 ("FAIL" . "#f2241f")
	 ("DONE" . "#86dc2f")
	 ("NOTE" . "#b1951d")
	 ("KLUDGE" . "#b1951d")
	 ("HACK" . "#b1951d")
	 ("TEMP" . "#b1951d")
	 ("FIXME" . "#dc752f")
	 ("XXX+" . "#dc752f")
	 ("\\?\\?\\?+" . "#dc752f")))
 '(package-selected-packages
   '(gdb-mi quelpa-use-package request quelpa company company-lsp company-prescient company-box company-tabnine auctex avy projectile highlight-indent-guides expand-region ivy ivy-rich ivy-posframe ivy-xref ivy-yasnippet ivy-prescient ivy-fuz amx counsel-projectile smartparens popwin evil evil-leader evil-collection evil-nerd-commenter treemacs treemacs-evil treemacs-projectile treemacs-magit winum which-key hydra markdown-mode lsp-mode lsp-java lsp-haskell dap-mode lsp-ui ccls lsp-python-ms yasnippet yasnippet-snippets auto-yasnippet use-package dashboard page-break-lines all-the-icons posframe cnfonts doom-themes doom-modeline solaire-mode base16-theme tao-theme hide-mode-line nasm-mode google-c-style sly sly-quicklisp racket-mode eshell-up eshell-did-you-mean gist telega org-download ox-hugo org-download persp-mode magit benchmark-init))
 '(pdf-view-midnight-colors '("#b2b2b2" . "#292b2e"))
 '(spacemacs-theme-comment-bg nil)
 '(spacemacs-theme-org-bold nil)
 '(spacemacs-theme-org-height nil)
 '(spacemacs-theme-org-priority-bold nil)
 '(spacemacs-theme-underline-parens nil)
 '(tab-width 4)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#ff9da4")
	 (40 . "#ffc58f")
	 (60 . "#ffeead")
	 (80 . "#d1f1a9")
	 (100 . "#99ffff")
	 (120 . "#bbdaff")
	 (140 . "#ebbbff")
	 (160 . "#ff9da4")
	 (180 . "#ffc58f")
	 (200 . "#ffeead")
	 (220 . "#d1f1a9")
	 (240 . "#99ffff")
	 (260 . "#bbdaff")
	 (280 . "#ebbbff")
	 (300 . "#ff9da4")
	 (320 . "#ffc58f")
	 (340 . "#ffeead")
	 (360 . "#d1f1a9")))
 '(vc-annotate-very-old-color nil)
 '(wakatime-api-key "df51420e-e377-44cf-80a5-4ca97c847496")
 '(wakatime-cli-path "/home/abcdlsj/.local/bin/wakatime")
 '(wakatime-python-bin nil)
 '(window-divider-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eshell-prompt ((t (:foreground "steel blue" :weight bold))))
 '(ivy-minibuffer-match-face-1 ((t (:inherit font-lock-doc-face :foreground nil))))
 '(lsp-ui-sideline-code-action ((t (:inherit warning))))
 '(org-checkbox ((t (:foreground nil :inherit org-todo)))))
(defcustom centaur-icon (display-graphic-p)
  "Display icons or not."
  :group 'centaur
  :type 'boolean)

(provide 'init-custom)

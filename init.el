;;                                    __ _                       _   _             
;; _ __ ___  _   _    ___ ___  _ __  / _(_) __ _ _   _ _ __ __ _| |_(_) ___  _ __  
;;| '_ ` _ \| | | |  / __/ _ \| '_ \| |_| |/ _` | | | | '__/ _` | __| |/ _ \| '_ \ 
;;| | | | | | |_| | | (_| (_) | | | |  _| | (_| | |_| | | | (_| | |_| | (_) | | | |
;;|_| |_| |_|\__, |  \___\___/|_| |_|_| |_|\__, |\__,_|_|  \__,_|\__|_|\___/|_| |_|
;;           |___/                         |___/                                   


(add-to-list 'load-path "~/.emacs.d/elp/")
(add-to-list 'load-path "~/.emacs.d/el/")

(require 'init-packages)
(require 'config)
(require 'init-keybindings)
(require 'init-org)
(require 'init-ui)

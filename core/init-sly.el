(add-to-list 'load-path "~/.emacs.d/elpa/sly")
(add-to-list 'load-path "~/.emacs.d/elpa/sly-quicklisp")
(require 'sly-autoloads)
(setq inferior-lisp-program "/usr/bin/clisp")
;(require 'sly-quicklisp-autoloads)

(provide 'init-sly)

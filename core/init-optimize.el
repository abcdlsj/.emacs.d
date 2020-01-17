;;; INIT-OPTIMIZE --- OPTIMIZATION
;;
;; Author: abcdlsj <lisongjianshuai@gmail.com>
;; Copyright © 2020, abcdlsj, all rights reserved.
;; Created: 17 一月 2020
;;
;;; Commentary:
;;
;;
;;
;;; Code:

(use-package benchmark-init
    :config
    (add-hook 'after-init-hook 'benchmark-init/activate))

(provide 'init-optimize)

;;; init-optimize.el ends here

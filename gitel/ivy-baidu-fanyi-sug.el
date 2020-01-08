(require 'request)
(require 'ivy)

(defun ivy-baidu-fanyi-suggest-fetch (keyword)
  (let* ((json-array-type 'list)
         (fanyi (request
                 "https://fanyi.baidu.com/sug"
                 :params `(("kw" . ,keyword))
                 :parser 'json-read
                 :sync t))
         (data (request-response-data fanyi))
         (err (request-response-error-thrown fanyi))
         (status (request-response-status-code fanyi)))
    (unless err
      (mapcar
       (lambda (x)
         (let-alist x
           (cons .k .v)))
       (alist-get 'data data))
      )))

(defun ivy-baidu-fanyi-suggest-candidates (&optional keyword)
  (mapcar
   (pcase-lambda (`(,word . ,meaning))
     (format "%-20s -- %s" word
             ;; 有时开头会有空格
             (string-trim meaning)))
   (ivy-baidu-fanyi-suggest-fetch
    (or keyword
        (string-trim
         (if (use-region-p)
             (buffer-substring-no-properties (region-beginning) (region-end))
           (substring-no-properties (or (thing-at-point 'word) ""))
           ))))))

(defun ivy-baidu-fanyi-suggest ()
  "百度翻译（搜索补全）."
  (interactive)
  (let* ((str (if (use-region-p)
                  (buffer-substring-no-properties (region-beginning) (region-end))
                (substring-no-properties (or (thing-at-point 'word) ""))))
         beg end candidates initial-input)
    (when str
      (setq beg (if (use-region-p) (region-beginning) (- (point) (length str)))
            end (if (use-region-p) (region-end) (point))
            candidates (ivy-baidu-fanyi-suggest-candidates))
      (setq ivy-completion-beg beg
            ivy-completion-end end)
      (setq initial-input (string-trim (car (split-string (car candidates) " -- "))))
      (ivy-read "Baidu Fanyi to complete:"
                (ivy-baidu-fanyi-suggest-candidates)
                :initial-input initial-input
                :action (lambda (cand)
                          (ivy-completion-in-region-action (string-trim (car (split-string cand " -- ")))))
                :caller 'ivy-baidu-fanyi-suggest
                ))))

(ivy-set-actions
 'ivy-baidu-fanyi-suggest
 `(("l" ,(lambda (candidate)
           (let* ((query (car (split-string candidate "  " t)))
                  ;; NOTE 只考虑中文 ⇔ 英文
                  ;; https://fanyi.baidu.com/#en/zh/aggressive
                  ;; https://fanyi.baidu.com/#zh/en/%E4%B8%AD%E5%9B%BD
                  (from (if (string-match-p "\\cC" query) 'zh 'en))
                  (to (pcase from
                        ('zh 'en)
                        ('en 'zh))))
             (browse-url
              (format "https://fanyi.baidu.com/#%s/%s/%s"
                      from to (url-hexify-string query)))))
    "Browse URL")))

(provide 'ivy-baidu-fanyi-sug)

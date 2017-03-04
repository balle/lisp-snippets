(ql:quickload "cl-redis")
(ql:quickload "drakma")

(setq *urls* '("www.heise.de"
	       "www.cliki.net/site/recent-changes"
	       "www.emacswiki.org/emacs/RecentChanges"
))

(defun save-site (url)
    (red:set (concatenate 'string "html:content:" url)
    (drakma:http-request (concatenate 'string "http://" url))))

(defun redis-fetch-key (key type)
  (case (find-symbol (string-upcase type) :keyword)
;    (:string
;     (red:get key))
    (:set
     (red:smembers key))
    (:hash
      (red:hgetall key))))

(defun redis-key-info (key)
  (let ((type (red:type key)))
    (format t "~a - ~a - ~a~%" key type (redis-fetch-key key type))))

(redis:connect :host "localhost")

(loop for url in *urls* do
    (save-site url))


(loop for key in (red:keys "*") do
     (redis-key-info key))

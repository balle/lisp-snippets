(setq bb-query-url "http://www.google.com/search?q=intitle%3A%22index.of%22%20%5Bdir%5D%20book")

(defun bb-parse-html (html)
  (with-temp-buffer 
    (insert html)
  )
)

(url-retrieve bb-query-url 'bb-parse-html)

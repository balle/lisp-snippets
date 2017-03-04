(ql:quickload :drakma)
(ql:quickload :cl-html5-parser)
(ql:quickload :cl-ppcre)

(use-package (list :drakma :html5-parser :cl-ppcre))

(setf (values *wikihtml* *responsecode* *headers*) 
      (http-request "http://en.wikipedia.org/wiki/Lisp"))
(setf *wikiDOM* (parse-html5 *wikihtml*))


;;
;; Loading modules
;;
(ql:quickload "hunchentoot")  ;; webserver
(ql:quickload "djula")        ;; django like templates
(ql:quickload "ironclad")     ;; crypto library


;;
;; Configuration
;;
(load "config.lisp")


;;
;; Templates
;;
(djula:add-template-directory "templates/")
(defvar +index-template+ (djula:compile-template* "index.clt"))


;;
;; Helper functions
;;
(defun generate-id (&optional len)
  (format nil "~{~a~}" (loop :repeat (or len 32) :collect (write-to-string (random 10)))))

(defun encrypt (data)
  "Encrypt the data with configured password using AES"
  data)

;; TODO: exception handling
(defun save (message upload_file)
  "Save uploaded message and/or file to a random generated file in upload-dir
   Returns output filename without suffix"
  (let ((out_filename (format nil "~a~a" (make-pathname :directory *upload-dir*) (generate-id))))
    (if upload_file
	(with-open-file (out (format nil "~a.file" out_filename)
			     :direction :output
			     :element-type '(unsigned-byte 8))
	  (with-open-file (in (car upload_file)
			      :element-type '(unsigned-byte 8))
	    (loop for byte = (read-byte in nil 'eof) until (eq byte 'eof) do
		 (write-byte byte out)))))

    (if message
	(with-open-file (out (format nil "~a.msg" out_filename)
			     :direction :output)
	(format out "~a~%" message)))
  out_filename))



;;
;; URL handlers
;;
(hunchentoot:define-easy-handler (index :uri "/") (message upload_file)
  (setf (hunchentoot:content-type*) "text/html")

  (let ((uploaded nil))
    (if (or message upload_file)
	  (setf uploaded (save message upload_file)))
    
    (with-output-to-string (stream)
      (djula:render-template* +index-template+ stream :uploaded uploaded))))


;;
;; static files
;;
(push (hunchentoot:create-folder-dispatcher-and-handler "/static/" "./static/") hunchentoot:*dispatch-table*)

;;
;; wanna debug some stuff?
;; (setf hunchentoot:*catch-errors-p* nil)

;; Listen on HTTP port
;;(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port *http-port*))

;; Listen on HTTPS port
(hunchentoot:start (make-instance 'hunchentoot:easy-ssl-acceptor
				  :ssl-privatekey-file *ssl-key-file*
				  :ssl-certificate-file *ssl-cert-file*
				  :port *https-port*
				  :document-root "."
				  :access-log-destination nil))

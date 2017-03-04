#!/usr/local/bin/sbcl --script

(defun f (max list)
    (remove-if (lambda (x) (>= x max)) list))

(format t "~A~%" (f (read) (read-list)))

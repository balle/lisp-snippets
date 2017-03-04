(defmacro let1 (var val &body body)
  `(let ((,var ,val))
     ,@body))

(defmacro thread (&rest body)
  `(sb-thread:make-thread (lambda () (,@body)) :name ,(gensym)))

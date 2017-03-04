(defparameter *noun* '(man
		       woman
		       dog
		       cat
		       tomato
		       banana
		       child)
  "Just a list of nouns")

(defparameter *article* '(the
			  a
			  one)
  "Just a list of articles")

(defparameter *verb* '(sees
		       hits
		       smells
		       chases
		       buys
		       sells)
  "Just a list of verbs")

(defun random-element (mylist)
  "return random list element"
  (nth (random (length mylist)) mylist))

(defun sentence ()
  "generate a random sentence"
  (list (random-element *article*)
	(random-element *noun*)
	(random-element *verb*)
	(random-element *article*)
	(random-element *noun*)))

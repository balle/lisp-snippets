; test
(defun handle-money (init-value)
  (let ((amount init-value)) 
    #'(lambda(&optional func x) 
	(if (and func x)
	    (setf amount (funcall func amount x))
	    amount))))

(defvar money (handle-money 50))
(defvar bet (handle-money 10))


(defun get-card ()
  (+ 1 (random 11)))

(defun count-card-values (cards)
  (reduce #'+ cards))

(defun busted (cards)
  (> (count-card-values cards) 21))

(defun new-card (cards)
  (push (get-card) cards))

(defun want-a-new-card ()
  (princ "Draw another card? (y/n) ")
  (not (equal (read) 'N)))

(defun players-turn (player)
  (loop 
     (if (and (not (busted player))
		  (want-a-new-card))
	 (progn
	   (setq player (new-card player))
	   (format t "Player ~A~%" player))
	 (return)))
  player)

(defun bank-turn (bank)
  (loop 
     (if (and (not (busted bank)) 
		(< (count-card-values bank) 17))
	   (setq bank (new-card bank))
	 (return)))
  bank)

(defun end-game (player bank)
  (let ((player-value (count-card-values player))
	(bank-value (count-card-values bank)))
    (cond ((> player-value 21)
	   (funcall money #'- (funcall bet))
	   (format t "You got busted! You loose.~%"))
	  ((> bank-value 21)
	   (funcall money #'+ (funcall bet))
	   (format t "Bank ~A~%Bank busted! You win!~%" bank))
	  ((equal player-value 21)
	   (funcall money #'+ (* 2 (funcall bet)))
	   (format t "Bank ~A~%You have a blackjack!~%" bank))
	  ((equal player-value bank-value)
	   (format t "Player ~A~%Bank ~A~%Pat~%" player bank))
	 ((< player-value bank-value)
	  (funcall money #'- (funcall bet))
	  (format t "Bank ~A~%You loose~%" bank))
	 ((> player-value bank-value)
	  (funcall money #'+ (funcall bet))
	  (format t "Bank ~A~%You win~%" bank)))))

(defun play-game ()
  (let ((bank (list (get-card)))
	(player (list (get-card) (get-card))))
    (if (< (show-money) (show-bet))
      (princ "You dont have enough money to place the bet")
      (progn
	(format t "Bank ~A~%" bank)
	(format t "Player ~A~%" player)

	(setq player (players-turn player))
	(setq bank (bank-turn bank))
	(end-game player bank))
      (funcall money))))

(defun show-money ()
  (funcall money))

(defun show-bet ()
  (funcall bet))

(defun place-bet (x)
  (funcall bet #'- (funcall bet))
  (funcall bet #'+ x))

(defun game-read ()
  (let ((cmd (read-from-string (concatenate 'string "(" (read-line) ")"))))
    (flet ((quote-it (x)
	     (list 'quote x)))
      (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))

(defun game-eval (cmd)
  (let ((allowed-commands '(place-bet play-game show-money show-bet 'quit)))
    (cond
      ((eq (car cmd) 'help)
       allowed-commands)
      ((member (car cmd) allowed-commands)
       (eval cmd))
      ((t)
       '(i do not know what to do.)))))

(defun game-repl ()
  (let ((cmd (game-read)))
    (unless (eq (car cmd) 'quit)
      (format t "~A~%" (game-eval cmd))
      (game-repl))))

(defun start-game ()
  (game-repl))

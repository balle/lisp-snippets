(setq bank ())
(setq player ())

(defun draw-card (whom)
  (let ((card (random 11)))
        (push card whom)
        (message (number-to-string card))))

(defun sum-cards (cards)
  (dolist (card cards)
    (let ((sum (+ sum card))))))

(defun score ()
  (let (player-score (sum-cards player))
       (bank-score (sum-cards bank))
       
       (cond ((or (> bank-score 21) (> player-score bank-score))
                  (message "You win!"))
             ((or (> player-score 21) (< player-score bank-score))
                  (message "You loose."))
             ((t) (message "Pat")))))

(defmacro players_turn ()
  (progn
    (and (y-or-n-p "Another card?")
         (< (sum-cards 'player) 21 ))))

(defmacro banks_turn ()
  (progn (< (sum-cards 'bank) 17)))

(draw-card bank)

(draw-card player)
(draw-card player)

(while (players_turn)
  (draw-card player))

(while banks_turn
  (draw-card bank))

(score)

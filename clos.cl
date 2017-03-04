(defclass vehicle ()
  ((wheels)
   (color
    :initarg :black)))

(defclass automobile (vehicle)
  ((wheels
    :initarg :4)))

(defclass motorbike (vehicle)
  ((wheels
    :initarg :2)))

(defmethod drive ((vehicle automobile))
  (format *standard-output* "Driving a car~%"))

(defmethod drive ((vehicle motorbike))
  (format *standard-output* "Flying over the street with a motorbike~%"))

(defvar ferrari (make-instance 'automobile))
(defvar kawasaki (make-instance 'motorbike))

(drive ferrari)
(drive kawasaki)

(defgeneric (setf color) (name myvehicle))
(defmethod (setf color) (name (myvehicle vehicle))
  (setf (slot-value myvehicle 'color) name))

(setf (color ferrari) 'red)

(defmethod color ((myvehicle vehicle))
  (slot-value myvehicle 'color))

(color ferrari)


  (defclass vehicle ()
    ((wheels)
     (color
      :initarg :black
      :reader color-get
      :writer (setf color-set)
      :accessor mycolor)))

  (setf (mycolor ferrari) 'red)
  (print (mycolor ferrari))

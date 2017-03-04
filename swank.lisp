(ql:quickload "swank")

(setf swank:*use-dedicated-output-stream* nil)
(setf swank:*communication-style* :fd-handler)
(swank:create-server :dont-close t)

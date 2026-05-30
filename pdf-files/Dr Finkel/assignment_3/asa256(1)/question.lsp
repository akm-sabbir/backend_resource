; each of the following query function is followed by its desired output
(defun  query_1()  (step ( finkel-eval '(((lambda (x) (function (lambda (y) (cons x y)))) 3) 4) nil))) ;(3 . 4)
(defun query_2() (finkel-eval '(((lambda (x) ( lambda (y) (cons 1 y)) ) 3) 4) nil) ) ;(1 . 3)
; grader: 	no, the proper result is (1 . 4).  -1
(defun query_3() (finkel-eval '(((lambda (x) ( lambda (y) (cdr (quote(1 y)))) ) 3) 4) nil) ) ;(3)
; grader: 	no, the proper result is (Y) because of the quoting. -1
(defun query_4() (finkel-eval '(((lambda (x) ( lambda (y) (car (quote(1 y)))) ) 3) 4) nil) ) ; 1
(defun query_5() (finkel-eval '(((lambda (x) ( lambda (y) (cons 1 2)) ) 3) 4) nil) ) ; (1 . 2)
(defun  query_6()  ( finkel-eval '(((lambda (x) (function (lambda (y) (car (quote(x y)))))) 3) 4) nil)) ; 3
; grader: 	no, the proper result is X because of the quoting. -0
(defun  query_7()  ( finkel-eval '(((lambda (x) (function (lambda (y) (cdr (quote(x y)))))) 3) 4) nil)) ; (4)
; grader: 	no, the proper result is (Y) because of the quoting. -0

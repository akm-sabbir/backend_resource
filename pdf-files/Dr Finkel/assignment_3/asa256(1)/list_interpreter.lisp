; grader: The file should be called lisp_interpreter.list  -1
(defun finkel-eval (list env)       ; evaluate list in env
  (cond
   ((null list) nil)
   ((numberp list) list)        ; Dieter added this
   ((stringp list) list)        ; Dieter added this
   ((eq t list) list)           ; Dieter added this
   ((atom list) (lookup list env)) ; Raphael removed Lisp-1.5 code
   ((eq (car list) 'quote) (car (cdr list)))
   ;((eq (car (car list)) 'lambda) (finkel-apply (car (cdr (cdr (car list)))) (evallist (cdr list) env) env ))
   ((eq (car list) 'function)  (cons (car(cdr list)) env))  ; this is where deep binding initiate by extending the environment function keyword signify that deep binding should be in effect
; grader: closure should be self-descriptive; see ReadMe.txt
   ((eq (car list) 'cond) (evalcond (cdr list) env))
   ((eq (car list) 'lambda) (cond ; handling of lambda function for shallow binding 
; grader: binding values is a terrible idea.  See ReadMe.
							 ( (eq (car(car(cdr(cdr list)))) 'cons) (cons (bind_val (car(cdr(cdr list))) env) nil) ); this handle cons function and surrogate all variable with corresponding bounden values
							 ( (eq (car(car(cdr(cdr list)))) 'car)  (cons (bind_val (car(cdr(cdr list))) env) nil)  ) ; similar as cons function but handle car function
							 ( (eq (car(car(cdr(cdr list)))) 'cdr) (cons (bind_val (car(cdr(cdr list))) env) nil) ) ; similarly handle cdr function
							   (t (cdr(cdr list)) ) ; for all other condition may not work comprehensively
							)
    )
   ( (eq (car list) 'car) (finkel-apply (car list) (cons (evallist (car(cdr(car(cdr list)))) env) nil) env)) ; special condition that handle car operation while implementing deep binding
; grader: I don't see why you added these two cases.  -1
   ( (eq (car list) 'cdr) (finkel-apply (car list) (cons (evallist (car(cdr(car(cdr list)))) env) nil) env)) ; special condition that handle cdr operation while implementing deep binding
   (t (finkel-apply (car list) (evallist (cdr list) env) env))))
(defun bind_val (list env) ; bind_val function is useful if body of a function contains both variable and constants it replaces all variables with their corresponding binded values
 ( cond 
	(( null list) nil)
	;((atom (car list) )(cons (car(cdr (car env))) (bind_val (cdr list) (cdr env) )) )
	((numberp (car list) ) (cons (car list) (bind_val (cdr list) env ) )) ; if its a number just keep it as it is
	((eq (car list) 'car) (cons (car list) (cons (bind_val (cdr list) env ) nil)  ) ) ; keep car syntax as it is
	((eq (car list) 'cdr) (cons (car list) (cons (bind_val (cdr list) env ) nil)  ) ) ; keep cdr syntax as it is
	((eq (car list) 'cons) (cons (car list) (bind_val (cdr list) env ) ) ) ; keep cons syntax as it is
	((atom (car list) ) (cons (car(cdr (car env))) (bind_val (cdr list) (cdr env) ) ) ) ; if find any variable replace that with its bounden value and variable must be locally accessible as it is shallow binding
	((eq (car(car list)) 'quote) (bind_val  (car(cdr (car list))) env )  ) ; this condition get rid of quote mark of list
	(t ( cons (car list) (bind_val (cdr list) env )  ) ) ; may add unwanted values however can be extended to handle more cases

 )
)
(defun finkel-apply (fct parms env) ; apply fct to parms
  (cond
   ((atom fct) (cond ; this condition handle the body of a function and interpret the function with its parameters values.
; grader: grammar: handles -0
; grader: puncutation: parameters'  -0
        ((eq fct 'car) (car (car parms)))
        ((eq fct 'cdr) (cdr (car parms)))
        ((eq fct 'cons) (cons (car parms)  (car (cdr parms)))) ; (cons( car parms) (car (cdr parms)))
        ((eq fct 'get) (get (car parms) (car (cdr parms))))
; grader: you don't need GET; you could remove it. -0
        ((eq fct 'atom) (atom (car parms)))
        ((eq fct 'error) (error (string parms)))
        ((eq fct 'eq) (eq (car parms) (car (cdr parms))))
        (t (cond
            ((get fct 'EXPR)
; grader: you don't need EXPR; you cold remove this case. -0
             (finkel-apply (get fct 'EXPR) parms env) parms env)
            (t (finkel-apply (lookup fct env) parms env))))))
   ((eq (car fct) 'lambda)
    (finkel-eval (car(cdr (cdr fct))) ; previously it was (car(cdr(cdr
; grader: you haven't actually changed the line above. -0
      (update (car (cdr fct)) parms env)))
   (t (extend_parms (finkel-eval fct env) parms env)))) ; extend_parms function choose between deep and shallow binding depending on the existence of extended environment
(defun extend_parms (fct parms env)
	(cond
	 ((null (cdr fct)) (finkel-apply (car(car fct))  (cdr(car fct)) env))  ; this line handle shallow binding as the cdr of fct is null means there is no extended environment
	 (t (finkel-apply (car fct) parms (cdr fct) )) ; ; this will be executed while deep binding in process as the cdr of fct carries the extended environment
	)
)
(defun evalcond (conds env)     ;evaluate cond
  (cond
   ((null conds) nil)
   ((finkel-eval (car (car conds)) env)
    (finkel-eval (car (cdr (car conds))) env))
   (t (evalcond (cdr conds) env))))

(defun evallist (list env)      ;evaluate list
  (cond
   ((null list) nil)
   (t (cons (finkel-eval (car list) env)
        (evallist (cdr list) env)))))

(defun lookup (id env)          ; lookup id
  (cond
   ((null env) (error "Unbound variable: ~S" id))
   ((eq id (car (car env))) (car (cdr (car env))))
   (t (lookup id (cdr env)))))

(defun update (formals vals env)    ; bind parameters
  (cond
   ((null formals)
    (cond ((null vals) env)
      (t (error "bad argument count"))))
   ((null vals) (error "bad argument count"))
   (t (cons (cons (car formals)
          (cons (car vals) nil))
        (update (cdr formals) (cdr vals) env)))))
; grader: (finkel-eval '(((lambda (x) (lambda (y) (cons x y))) 3) 4) nil)
;   should give error unbound X but it doesn't.  -3

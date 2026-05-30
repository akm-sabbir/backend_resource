; grader: external documentation: what does the program do?  -2

1. Open the make file. It contains load_1 and load_2 two functions, running these two function from clisp command interpreter will load
; grader: Please limit lines to 80 columns.  -0
; grader: grammar: two functions  -0
; grader: that's not a make file.  And no need to open it. -1
   all the necessary functions we need to evaluate our interpreter.
2. after loading these two functions. we need to run the corresponding functions in following way,
   (load_1)
   (load_2)
3. After that run (query_1) and subsequent other query functions and will output the result at the command window.
4. list_interpreter.lisp file contains main lisp interpreter code.
5. question.lsp file contains different test cases.

; grader: closure should be self-descriptive (CLOSURE).  -1
instead, when I give this input:
    (finkel-eval '(function (lambda (y) (cons x y))) '((x 3))) 
I get: 
    ((LAMBDA (Y) (CONS X Y)) (X 3))
where I would expect
    (CLOSURE (LAMBDA (Y) (CONS X Y)) (X 3))

; grader: You didn't fix the interpretation of lambda, so
; grader: the following of my test cases fail. Expected results shown.  -1
(finkel-eval '(((lambda (x) ( lambda (y) (cons x y)) ) 3) 4) nil) ; unbound x
(finkel-eval '(lambda (x) 3) nil) ;  (LAMBDA (X) 3)
(finkel-eval '(((lambda (y) (lambda (x) (cons x y))) 2) 3) '((x 3)))
    ; unbound variable: Y

; grader: the following should give unbound X, but you give (3).  -3
(finkel-eval '(((lambda (x) (lambda (y) (cons x y))) 3) 4) nil)

; grader: closure should be self-descriptive (CLOSURE).  -1
instead, when I give this input:
    (finkel-eval '(function (lambda (y) (cons x y))) '((x 3)))
I get:
    ((LAMBDA (Y) (CONS X Y)) (X 3))
where I would expect
    (CLOSURE (LAMBDA (Y) (CONS X Y)) (X 3))

; grader: the following input should just give (LAMBDA (Y) (CONS X Y))
(finkel-eval '(lambda (y) (cons x y)) '((x 3)))
instead, you give ((CONS 3 NIL)), so you are replacing atoms with their values
; grader  -8


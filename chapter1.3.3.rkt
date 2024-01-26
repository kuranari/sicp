#lang racket
(require racket/trace)

((lambda (x y z) (+ x y z)) 1 2 3)

(define x 5)
(+ (let ((x 3))
     (+ x (* x 10)))
   x)

(let ((x 3)
      (y (+ x 2)))
  (* x y))

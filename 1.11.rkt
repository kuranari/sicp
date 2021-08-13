#lang racket
(require racket/trace)


(define (f1 n)
  (if (< n 3)
      n
      (+
       (f1 (- n 1))
       (* 2 (f1 (- n 2)))
       (* 3 (f1 (- n 3))))))

(f1 0) ; 0
(f1 1) ; 1
(f1 2) ; 2
(f1 3) ; 4
(f1 4) ; 11
(f1 5) ; 25


(define (f2 n)
  (define (f2-iter n1 n2 n3 count)
    (if (= count 0)
        n1
        (f2-iter (+ n1 (* 2 n2) (* 3 n3)) n1 n2 (- count 1))
        ))
  ;; (trace f2-iter)
  (if (< n 3)
      n
      (f2-iter 2 1 0 (- n 2))))

(f2 0) ; 0
(f2 1) ; 1
(f2 2) ; 2
(f2 3) ; 4
(f2 4) ; 11
(f2 5) ; 25

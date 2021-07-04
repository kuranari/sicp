#lang racket
(require rackunit)

(define (square x) (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (sum-of-squares-max2 a b c)
  (cond
    ((and (>= a c) (>= b c)) (sum-of-squares a b))
    ((>= a b) (sum-of-squares a c))
    (else (sum-of-squares b c))
    ))

(check-eq? (sum-of-squares-max2 3 2 1) 13)
(check-eq? (sum-of-squares-max2 1 2 3) 13)
(check-eq? (sum-of-squares-max2 2 3 1) 13)
(check-eq? (sum-of-squares-max2 2 2 2) 8)
(check-eq? (sum-of-squares-max2 3 4 1) 25)


#lang racket

(define (square x) (* x x))

(define (good-enough? x y)
  (< (abs (- x y)) 0.001))

(define (cube-root-iter guess x)
  (if (good-enough? guess (improve guess x))
      guess
      (cube-root-iter (improve guess x)
                 x)))

(define (improve guess x)
  (/
   (+ (/ x (square guess)) (* 2 guess))
   3))

(define (cube-root x)
  (cube-root-iter 1.0 x))

(cube-root 1)
(cube-root 8)
(cube-root 27)
(cube-root 64)


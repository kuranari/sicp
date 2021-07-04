#lang racket

;; 作用的順序で評価が行われる処理系で特殊形式でないnew-ifを使う場合、good-enough?の結果がどうであれ、引数のsqrt-iterが呼び出される。結果としてこの手続きは停止しないものになる

(define (square x) (* x x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(new-if (= 2 3) 0 5)
(new-if (= 1 1) 0 5)

(sqrt 9)


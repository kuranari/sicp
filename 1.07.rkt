#lang racket

(define (square x) (* x x))

;; (define (good-enough? guess x)
;;   (< (abs (- (square guess) x)) 0.001))

;; (define (sqrt-iter guess x)
;;   (if (good-enough? guess x)
;;           guess
;;           (sqrt-iter (improve guess x)
;;                      x)))

(define (good-enough? x y)
  (< (abs (- x y)) 0.001))

(define (sqrt-iter guess x)
  (if (good-enough? guess (improve guess x))
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt x)
  (sqrt-iter 1.0 x))

;; 許容値に対し、被開平数が非常に小さい場合
;; これは、予測値の二乗と被開平数の差が許容値以下になった時点で、必要な精度に達する前に計算が打ち切られるためである。
(square (sqrt 1))
(square (sqrt 0.1))
(square (sqrt 0.01))
(square (sqrt 0.001))
(square (sqrt 0.0001))
(square (sqrt 0.00001))
(square (sqrt 0.000001))

;; 許容値に対し、被開平数が非常に大きい場合
;; good-enough?が常に偽となり、計算が停止しない。
;; これは、計算精度の問題で予測値の二乗が被開平数の差が許容値以下にならないためである。
(square (sqrt 1000000000000))
(square (sqrt 10000000000000))

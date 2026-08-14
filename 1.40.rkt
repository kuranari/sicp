;; 開始: 2026-08-14(Fri) 20:26:07
;; 終了: 2026-08-14(Fri) 20:43:11

#lang racket
(require racket/trace)

;; 問題1.40
;; newtons-method と組み合わせて
;;   (newtons-method (cubic a b c) 1)
;; の形で使える手続き cubic を定義せよ。
;; これは三次方程式 x^3 + ax^2 + bx + c の零点を近似する。

;; chapter1.3.3.rktからコピー
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next) next (try next))))
  (try first-guess))

;; chapter1.3.4.rktからコピー
(define dx 0.00001)
(define (deriv g)
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))
(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

;; cubic を実装する
(define (square x) (* x x))
(define (cube x) (* x x x))
(define (cubic a b c)
  (lambda (y) (+ (cube y) (* a (square y)) (* b y) c)))

(newtons-method (cubic 1 1 1) 1)
(newtons-method (cubic 1 2 4) 1)

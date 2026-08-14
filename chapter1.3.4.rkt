;; 開始: 2026-08-14(Fri) 19:59:40

#lang racket
(require racket/trace)

;; chapter1.3.3.rktからコピー
(define (average x y) (/ (+ x y) 2))

;; chapter1.3.3.rktからコピー
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next) next (try next))))
  (try first-guess))

;; 1.3.4 手続きを返す手続き

(define (average-damp f) (lambda (x) (average x (f x))))
(define (square x) (* x x))

((average-damp square) 10)
;; (define (sqrt x)
;;   (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))
;; (sqrt 2)

(define (cube-root x)
  (fixed-point (average-damp (lambda (y) (/ x (square y))))
               1.0))

(cube-root 8)

;; ニュートン法

(define dx 0.00001)
(define (deriv g)
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))

(define (cube x) (* x x x))
((deriv cube) 5)

(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

;; (define (sqrt x)
;;   (newtons-method
;;    (lambda (y) (- (square y) x)) 1.0))
;; (sqrt 2)

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))


; 平均減衰バージョンの不動点演算
(define (sqrt x)
  (fixed-point-of-transform
   (lambda (y) (/ x y)) average-damp 1.0))

; ニュートン変形の不動点を探すニュートン法
(define (sqrt2 x)
  (fixed-point-of-transform
   (lambda (y) (- (square y) x)) newton-transform 1.0))

(sqrt 2)
(sqrt2 2)

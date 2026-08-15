;; 開始: 2026-08-16(Sun) 05:45:20
;; 終了: 2026-08-16(Sun) 06:08:15

#lang racket
(require racket/trace)

;; 2.1.2 抽象化の壁 (Abstraction Barriers)

;; chapter1.2.5.rktからコピー
(define (gcd a b)
  (if (= b 0) a (gcd b (remainder a b))))

;; chapter2.1.1.rktからコピー
(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))
(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))
(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (make-rat n d) (cons n d))
(define (numer x)
  (let ((g (gcd (car x) (cdr x))))
    (/ (car x) g)))
(define (denom x)
  (let ((g (gcd (car x) (cdr x))))
    (/ (cdr x) g)))

(print-rat (make-rat 2 3))
(print-rat (make-rat -2 3))
(print-rat (make-rat 2 -3))
(print-rat (make-rat -2 -3))

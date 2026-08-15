;; 開始: 2026-08-16(Sun) 05:22:38
;; 終了: 2026-08-16(Sun) 05:42:14

#lang racket
(require racket/trace)

;; 問題2.1
;; 正の引数にも負の引数にも対応する、より良い make-rat を定義せよ。
;; make-rat は符号を正規化し、
;;   - 有理数が正なら、分子・分母ともに正
;;   - 有理数が負なら、分子だけが負
;; となるようにすること。

;; chapter1.2.5.rktからコピー
(define (gcd a b)
  (if (= b 0) a (gcd b (remainder a b))))

;; chapter2.1.1.rktからコピー
(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

;; TODO: 符号を正規化する make-rat を実装する

(define (make-rat n d)
  (let ((g (gcd n d)))
    (let ((n1 (/ n g)) (d1 (/ d g)))
      (if (> d1 0) (cons n1 d1) (cons (- n1) (- d1))))))

(print-rat (make-rat 2 3))
(print-rat (make-rat -2 3))
(print-rat (make-rat 2 -3))
(print-rat (make-rat -2 -3))

(print-rat (make-rat 6 4))
(print-rat (make-rat -6 4))
(print-rat (make-rat 6 -4))
(print-rat (make-rat -6 -4))

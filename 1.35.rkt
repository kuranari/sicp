;; 開始: 2026-07-26(Sun) 01:24:42
;; 終了: 2026-07-26(Sun) 01:47:54

#lang racket
(require racket/trace)

;; 問題1.35
;; 黄金比 φ (1.2.2節) が変換 x -> 1 + 1/x の不動点であることを示し、
;; fixed-point 手続きを使ってこれを計算せよ。

;; chapter1.3.4.rktからデッドコピー
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next) next (try next))))
  (try first-guess))

;; 黄金比は x^2 = x + 1を満たす。
;; 両辺を x で割ると x = 1 + 1/x となる

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)
;; 開始: 2021-07-24(Sat) 21:30:29
;; 終了: 2021-07-24(Sat) 21:44:03

#lang racket
(require racket/trace)

(define (double x) (* x 2))
(define (halve x) (/ x 2))

;; a x b + cを不変量とする
;; 2 x 7
;; = (2 x 6) + 2
;; = (4 x 3) + 2
;; = (4 x 2) + 6
;; = (8 x 1) + 6
;; = (8 x 0) + 14

(define (fast-product a b)
  (define (fast-product-iter a b c)
    (cond ((= b 0) c)
          ((even? b) (fast-product-iter (double a) (halve b) c))
          (else (fast-product-iter a (- b 1) (+ a c))))
    )
  (trace fast-product-iter)
  (fast-product-iter a b 0)
  )

(fast-product 2 3)
(fast-product 2 0)
(fast-product 0 2)

(fast-product 57 53)

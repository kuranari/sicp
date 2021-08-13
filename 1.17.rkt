;; 開始: 2021-07-24(Sat) 21:07:30
;; 終了: 2021-07-24(Sat) 21:28:47

#lang racket
(require racket/trace)

(define (product a b)
  (if (= b 0) 0 (+ a (product a (- b 1)))))

;; (trace product)
(product 2 3)
(product 2 0)
(product 0 2)

(define (double x) (* x 2))
(define (halve x) (/ x 2))

(define (fast-product a b)
  (cond ((= b 0) 0)
        ((even? b) (double (fast-product a (halve b))))
        (else (+ a (fast-product a (- b 1))))
   ))

;; (trace fast-product)
(fast-product 2 3)
(fast-product 2 0)
(fast-product 0 2)

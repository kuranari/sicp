;; 開始: 2021-08-29(Sun) 18:04:30
;; 終了: 2021-08-29(Sun) 18:30:43

#lang racket
(require racket/trace)

(define (product-rec term a next b)
  (if (> a b)
      1
      (* (term a)
         (product-rec term (next a) next b))))

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(define (inc n) (+ n 1))
(define (identity n) n)

(define (factorial-rec n)
  (product-rec identity 1 inc n))

(define (factorial-iter n)
  (product-iter identity 1 inc n))

(factorial-rec 5)
(factorial-iter 5)



(define (pi n)
  (define (numerator x) (if (odd? x) (+ x 1) (+ x 2)))
  (define (denominator x) (if (odd? x) (+ x 2) (+ x 1)))
  (define (term x) (/ (numerator x) (denominator x)))

  (* 4.0 (product-iter term 1.0 inc n)))

(pi 1)
(pi 10)
(pi 100)
(pi 1000)
(pi 10000)
(pi 100000)
(pi 1000000)

;; 開始: 2021-08-29(Sun) 21:15:56
;; 終了: 2021-08-29(Sun) 21:25:56

#lang racket
(require racket/trace)

(define (accumulate-rec combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
         (accumulate-rec combiner null-value term (next a) next b))))

(define (accumulate-iter combiner null-value term a next b)
 (define (iter a result)
   (if (> a b)
       result
       (iter (next a) (combiner result (term a)))))
 (iter a null-value))

(define (product-rec term a next b)
  (accumulate-rec * 1 term a next b))

(define (product-iter term a next b)
  (accumulate-iter * 1 term a next b))

(define (sum-rec term a next b)
  (accumulate-rec + 0 term a next b))

(define (sum-iter term a next b)
  (accumulate-iter + 0 term a next b))

(define (inc n) (+ n 1))
(define (identity n) n)

(define (factorial-rec n)
  (product-rec identity 1 inc n))

(define (factorial-iter n)
  (product-iter identity 1 inc n))

(factorial-rec 5)
(factorial-iter 5)

(sum-rec identity 0 inc 10)
(sum-iter identity 0 inc 10)

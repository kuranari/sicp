;; 開始: 2021-08-29(Sun) 21:26:35
;; 終了: 2021-08-29(Sun) 21:47:01

#lang racket
(require racket/trace)

(define (filtered-accumulate combiner null-value condition term a next b)
  (if (> a b)
      null-value
      (combiner (if (condition a) (term a) null-value)
                (filtered-accumulate combiner null-value condition term (next a) next b))))


(define (inc n) (+ n 1))
(define (sum-of-square-of-prime a b)
  (define (square x) (* x x))

  ;; 1.22で使用したナイーブな判定方法を使用
  (define (smallest-divisor n) (find-divisor n 2))
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))
  (define (divides? a b) (= (remainder b a) 0))
  (define (prime? n)
    (= n (smallest-divisor n)))

  (filtered-accumulate + 0 prime? square a inc b))

(sum-of-square-of-prime 1 7)

(define (product-of-coprime n)
  (define (identity n) n)

  (define (gcd a b)
    (if (= b 0) a (gcd b (remainder a b))))
  (define (coprime? x) (= (gcd x n) 1))

  (filtered-accumulate * 1 coprime? identity 1 inc (- n 1)))

(product-of-coprime 8)

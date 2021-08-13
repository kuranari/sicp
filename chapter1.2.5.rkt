;; 開始: 2021-07-27(Tue) 21:52:46

#lang racket
(require racket/trace)

(define (gcd a b)
  (if (= b 0) a (gcd b (remainder a b))))

(trace gcd)
(gcd 206 40)

;; 開始: 2021-08-13(Fri) 15:06:31
;; 終了: 2021-08-13(Fri) 15:23:23
#lang racket
(require racket/trace)

(define (square x) (* x x))
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (modulo (square (expmod base (/ exp 2) m)) m))
        (else (modulo (* (modulo base m) (expmod base (- exp 1) m)) m))))

(define (fermat-test a n) (= (expmod a n n) a))

(define (fast-prime-all? n)
  (define (fast-prime? a n)
    (cond ((= a n) true)
          ((fermat-test a n) (fast-prime? (+ a 1) n))
          (else false)))
  (fast-prime? 0 n))

(fast-prime-all? 17)
(fast-prime-all? 19)
(fast-prime-all? 21)

;; Carmichael number
(fast-prime-all? 561)
(fast-prime-all? 1105)
(fast-prime-all? 1729)
(fast-prime-all? 2465)
(fast-prime-all? 2821)
(fast-prime-all? 6601)

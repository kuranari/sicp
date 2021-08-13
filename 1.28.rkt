;; 開始: 2021-08-13(Fri) 15:28:34
;; 終了: 2021-08-13(Fri) 16:38:02

#lang racket
(require racket/trace)

(define (square x) (* x x))
(define (square-mod x m)
  (if (and
       (not (= x 1))
       (not (= x (- m 1)))
       (= (modulo (square x) m) 1))
      0
      (square x)))

(define (expmod base exp m)
  (define (if-exp condition m) (if (= condition 1) 0 condition))
  (trace if-exp)
  (cond ((= exp 0) 1)
        ((even? exp)
         (modulo (square-mod (expmod base (/ exp 2) m) m) m))
        (else
         (modulo (* (modulo base m) (expmod base (- exp 1) m)) m))))

(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((miller-rabin-test n) (fast-prime? n (- times 1)))
        (else false)))

(fast-prime? 17 5)
(fast-prime? 19 5)
(fast-prime? 21 5)

;; Carmichael number
;; フェルマーテストで素数として誤判定されることは1.27.rkt参照
(fast-prime?  561 2)
(fast-prime? 1105 2)
(fast-prime? 1729 2)
(fast-prime? 2465 2)
(fast-prime? 2821 2)
(fast-prime? 6601 2)

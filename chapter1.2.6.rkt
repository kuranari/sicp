;; 開始: 2021-07-31(Sat) 21:32:05

#lang racket
(require racket/trace)

(define (square x) (* x x))
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)              ; sqrt(n)までを調べる
        ((divides? test-divisor n) test-divisor)     ; 割り切れるものがあれば計算を打ち切る
        (else (find-divisor n (+ test-divisor 1))))) ; 割り切れなければ候補を+1する
(define (divides? a b) (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(prime? 3)
(prime? 1000000007)

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (modulo (square (expmod base (/ exp 2) m)) m))
        (else (modulo (* (modulo base m) (expmod base (- exp 1) m)) m))))

;; (expmod 2 0 5)
;; (expmod 2 1 5)
;; (expmod 2 2 5)
;; (expmod 2 3 5)
;; (expmod 2 4 5)
;; (trace expmod)
;; (expmod 2 5 5)


(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(fast-prime? 1000000007 10)

;; practice 1.21
(smallest-divisor 199)
(smallest-divisor 1999)
(smallest-divisor 19999)

;; practice 1.22

(define (runtime) (current-inexact-milliseconds))
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

;; https://stackoverflow.com/questions/10863192/why-is-one-armed-if-missing-from-racket
(define (start-prime-test n start-time)
  (when (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))


(define (search-for-primes s1 s2)
  (when (<= s1 s2)
    (timed-prime-test s1)
    (search-for-primes (+ s1 1) s2)))


;; 1009 *** 0.0009765625
;; 1013 *** 0.0009765625
;; 1019 *** 0.0009765625
;; (search-for-primes 1000 1020)

;; 10007 *** 0.0009765625
;; 10009 *** 0.001220703125
;; 10037 *** 0.001953125
;; (search-for-primes 10000 10050)

;; 100003 *** 0.004150390625
;; 100019 *** 0.007080078125
;; 100043 *** 0.004150390625
;; (search-for-primes 100000 100050)

;; 1000003 *** 0.0498046875
;; 1000033 *** 0.011962890625
;; 1000037 *** 0.012939453125
;; (search-for-primes 1000000 1000050)

;; 10000019 *** 0.0390625
;; 10000079 *** 0.04296875
;; 10000103 *** 0.0390625
(search-for-primes 10000000 10000200)

;; 100000007 *** 0.1201171875
;; 100000037 *** 0.151123046875
;; 100000039 *** 0.120849609375

;; 1000000007 *** 0.43212890625
;; 1000000009 *** 0.411865234375
;; 1000000021 *** 0.410888671875

;; 10000000019 *** 1.648193359375
;; 10000000033 *** 1.535888671875
;; 10000000061 *** 1.305908203125

(search-for-primes 100000000000 100000000200)
;; 100000000003 *** 4.33984375
;; 100000000019 *** 4.4208984375
;; 100000000057 *** 5.136962890625

;; sqrt(10) = 3.162
;; 1桁増える度に、実行時間は3.16倍になる
;; 1000の場合の実行時間を0.001秒とした場合の、想定時間
;; 1000    : 0.001
;; 10000   : 0.00316
;; 100000  : 0.0099856
;; 1000000 : 0.031554496
;; 10000000: 0.099712207
;; 概ねsqrt(10)程度の増加率になっている。

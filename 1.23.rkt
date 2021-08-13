#lang racket
(require racket/trace)

(define (square x) (* x x))

(define (runtime) (current-inexact-milliseconds))
(define (timed-prime-test n next)
  (define (prime? n)
    (define (smallest-divisor n) (find-divisor n 2))
    (define (find-divisor n test-divisor)
      (cond ((> (square test-divisor) n) n)              ; sqrt(n)までを調べる
            ((divides? test-divisor n) test-divisor)     ; 割り切れるものがあれば計算を打ち切る
            (else (find-divisor n (next test-divisor))))) ; 割り切れなければ候補を+1する
    (define (divides? a b) (= (remainder b a) 0))

    (= n (smallest-divisor n)))
  (define (start-prime-test n start-time)
    (when (prime? n)
      (report-prime (- (runtime) start-time))))

  (define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))

  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (timed-prime-tests n)
  (define (add1 n) (+ n 1))
  (define (add1-or-2 n) (if (= n 2) (+ n 1) (+ n 2)))
  (timed-prime-test n add1)
  (timed-prime-test n add1-or-2))

;; マイクロ秒の差であるため、測定誤差が大きいが速度は約2倍になる
;; 仮に処理時間が完全に2倍とならないのであれば add1-or-2 関数で毎回ifの判定を行なっていることに起因すると考えられる

;; (timed-prime-tests 1009)
;; (timed-prime-tests 1013)
;; (timed-prime-tests 1019)

;; (timed-prime-tests 10007)
;; (timed-prime-tests 10009)
;; (timed-prime-tests 10037)

;; (timed-prime-tests 100003)
;; (timed-prime-tests 100019)
;; (timed-prime-tests 100043)

;; (timed-prime-tests 1000003)
;; (timed-prime-tests 1000033)
;; (timed-prime-tests 1000037)

;; (timed-prime-tests 10000019)
;; (timed-prime-tests 10000079)
;; (timed-prime-tests 10000103)

(timed-prime-tests 1000000007)
(timed-prime-tests 1000000009)
(timed-prime-tests 1000000021)

(timed-prime-tests 10000000019)
(timed-prime-tests 10000000033)
(timed-prime-tests 10000000061)

(timed-prime-tests 100000000003)
(timed-prime-tests 100000000019)
(timed-prime-tests 100000000057)

;; 1009 *** 0.0009765625
;; 1013 *** 0.0009765625
;; 1019 *** 0.0009765625
;; 10007 *** 0.0009765625
;; 10009 *** 0.001220703125
;; 10037 *** 0.001953125
;; 100003 *** 0.004150390625
;; 100019 *** 0.007080078125
;; 100043 *** 0.004150390625
;; 1000003 *** 0.0498046875
;; 1000033 *** 0.011962890625
;; 1000037 *** 0.012939453125
;; 10000019 *** 0.0390625
;; 10000079 *** 0.04296875
;; 10000103 *** 0.0390625

;; 1000000007 *** 0.43212890625
;; 1000000009 *** 0.411865234375
;; 1000000021 *** 0.410888671875

;; 10000000019 *** 1.648193359375
;; 10000000033 *** 1.535888671875
;; 10000000061 *** 1.305908203125

;; 100000000003 *** 4.33984375
;; 100000000019 *** 4.4208984375
;; 100000000057 *** 5.136962890625

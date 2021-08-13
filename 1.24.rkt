;; 開始: 2021-08-13(Fri) 06:53:24
;; 終了: 2021-08-13(Fri) 07:29:27
#lang racket
(require racket/trace)

(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (modulo (square (expmod base (/ exp 2) m)) m))
        (else (modulo (* (modulo base m) (expmod base (- exp 1) m)) m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (runtime) (current-inexact-milliseconds))
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (when (fast-prime? n 10000)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(timed-prime-test 1000003)
(timed-prime-test 1000033)
(timed-prime-test 1000037)

(timed-prime-test 10000019)
(timed-prime-test 10000079)
(timed-prime-test 10000103)

(timed-prime-test 100000007)
(timed-prime-test 100000037)
(timed-prime-test 100000039)

(timed-prime-test 1000000007)
(timed-prime-test 1000000009)
(timed-prime-test 1000000021)

;; log(n)の増加率であれば、桁が10倍になっても実行時間は2倍になるのみなので1000倍の桁数を計算するためには約8倍の時間がかかる
;; 実際には実行時間は約2倍に抑えられている
;; 違いは...説明できない
;;
;; https://codology.net/post/sicp-solution-exercise-1-24/
;; 上記サイトを確認した。
;; 1,000に近い素数と1,000,000に近い素数だけでは必要な時間は判断できない。
;; 必要な時間を求めるためには、1,000に近い素数の実行時間(t1)と10,000に近い素数の実行時間(t2)の差(delta)を求めて、(t1 + 4 * delta)を計算する必要がある。
;; log(1,000,000) - log(1,000) = 4

;; フェルマーテストの試行回数: 10000
;; 1000003 *** 6.81201171875
;; 1000033 *** 7.02783203125
;; 1000037 *** 7.447998046875
;; 10000019 *** 8.005126953125
;; 10000079 *** 8.578125
;; 10000103 *** 8.85107421875
;; 100000007 *** 9.660888671875
;; 100000037 *** 9.548095703125
;; 100000039 *** 9.7939453125
;; 1000000007 *** 10.365966796875
;; 1000000009 *** 10.633056640625
;; 1000000021 *** 10.298095703125

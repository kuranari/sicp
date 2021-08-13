;; 開始: 2021-07-24(Sat) 22:08:37
;; 終了: 2021-07-24(Sat) 23:10:58

#lang racket
(require racket/trace)

(define (fib n) (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))
                   (+ (* q q) (* 2 p q))
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

(fib 0)
(fib 1)
(fib 2)
(fib 3)
(trace fib-iter)
(fib 100)

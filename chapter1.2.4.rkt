#lang racket
(require racket/trace)

(define (square x) (* x x))
;; (define (fast-exp b n)
;;   (if (= n 1) b (square (fast-exp b (/ n 2)))))

(define (fast-exp b n)
  (cond ((= n 1) b)
        ((even? n) (square (fast-exp b (/ n 2))))
        (else (* b (fast-exp b (- n 1))))))
(fast-exp 2 1)
(fast-exp 2 2)
(fast-exp 2 3)
(fast-exp 2 4)
(fast-exp 3 3)

(trace fast-exp)
(fast-exp 2 20)

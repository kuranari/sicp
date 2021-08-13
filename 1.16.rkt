;; start: 2021-07-23(金) 16:06:20
;; end:   2021-07-23(金) 17:06:40

#lang racket
(require racket/trace)

(define (square x) (* x x))

(define (fast-expt b n)
  (define (fast-expt-iter b n a)
    (cond ((= n 0) a)
          ((even? n) (fast-expt-iter (square b) (/ n 2) a))
          (else (fast-expt-iter b (- n 1) (* a b)))
          ))
  (trace fast-expt-iter)
  (fast-expt-iter b n 1))

;; [参考] 再帰プロセス
;; (define (fast-expt-rec b n)
;;   (cond ((= n 1) b)
;;         ((even? n) (square (fast-expt-rec b (/ n 2))))
;;         (else (* b (fast-expt-rec b (- n 1))))))

(fast-expt 2 0)
(fast-expt 2 8)
(fast-expt 2 9)
(fast-expt 3 4)
(fast-expt 2 1000)

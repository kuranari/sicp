;; 開始: 2026-08-23(Sun) 15:58:05
;; 終了: 2026-08-23(Sun) 16:03:50

#lang racket
(require racket/trace)

;; 2.1.3 データとは何か (What Is Meant by Data?)

(define (cons x y)
  (define (dispatch m)
    (cond ((= m 0) x)
          ((= m 1) y)
          (else (error " Argument not 0 or 1: CONS " m ))))
  dispatch )

(define (car z) (z 0))
(define (cdr z) (z 1))

(define pair (cons 1 2))
(car pair)
(cdr pair)

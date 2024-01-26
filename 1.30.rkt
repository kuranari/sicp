;; 開始: 2021-08-22(Sun) 17:47:46
;; 終了: 2021-08-22(Sun) 17:50:58

#lang racket
(require racket/trace)

(define (inc n) (+ n 1))
(define (identity x) x)
(define (cube x) (* x x x))

;; (define (sum term a next b)
;;   (if (> a b)
;;       0
;;       (+ (term a)
;;          (sum term (next a) next b))))

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

(sum identity 0 inc 10)
(sum cube 0 inc 10)

(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term a pi-next b))

(* 8 (pi-sum 1 1000))

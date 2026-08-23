;; 開始: 2026-08-23(Sun) 16:27:03
;; 終了: 2026-08-23(Sun) 17:01:51

#lang racket
(require racket/trace)

;; 問題2.5
;; 非負整数の対 a と b を、積 2^a * 3^b である整数として表現すれば、
;; 数と算術演算だけで対を表現できることを示せ。
;;
;; 対応する cons, car, cdr の定義を与えよ。

;; TODO: cons を定義する
(define (cons a b)
  (* (expt 2 a) (expt 3 b)))


(define (count-divisions n d)
  (define (count k i)
    (if (= (remainder k d) 0) (count (quotient k d) (+ i 1)) i))
  (count n 0))

;; TODO: car を定義する
(define (car n)
  (count-divisions n 2))

;; TODO: cdr を定義する
(define (cdr n)
  (count-divisions n 3))

;; TODO: 動作を確認する
(define pair (cons 3 5))
(car pair)
(cdr pair)

(define pair2 (cons 0 0))
(car pair2)
(cdr pair2)

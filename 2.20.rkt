;; 開始: 2026-09-06(Sun) 11:24:38
;; 終了: 2026-09-06(Sun) 11:39:04

#lang racket
(require racket/trace)

;; 問題2.20
;; Scheme には任意個の引数を取る手続きを書くための「ドット記法」がある。
;;
;;   (define (f x y . z) <body>)
;;
;; と定義すると、f は 2 個以上の引数を取り、x と y には最初の 2 つが束縛され、
;; z には残りの引数のリストが束縛される。
;;
;;   (f 1 2 3 4 5 6)  →  x=1, y=2, z=(3 4 5 6)
;;
;;   (define (g . w) <body>)
;;
;; と定義すると、g は任意個の引数を取り、w にはその全てのリストが束縛される。
;;
;;   (g 1 2 3 4 5 6)  →  w=(1 2 3 4 5 6)
;;   (g)              →  w=()
;;
;; この記法を使って、1 個以上の整数を受け取り、
;; 最初の引数と同じ偶奇性 (even/odd parity) を持つ引数だけからなるリストを返す
;; 手続き same-parity を定義せよ。
;;
;; (same-parity 1 2 3 4 5 6 7)
;; -> (1 3 5 7)
;; (same-parity 2 3 4 5 6 7)
;; -> (2 4 6)

;; TODO: filter を定義する
(define (filter proc lst)
  (if (null? lst) lst
      (if (proc (car lst))
          (cons (car lst) (filter proc (cdr lst)))
          (filter proc (cdr lst)))))

(filter odd? (list 1 2 3 4 5))
(filter even? (list 1 2 3 4 5))

;; TODO: same-parity を定義する
(define (same-parity fst . lst)
  (cons fst
        (if (odd? fst) (filter odd? lst) (filter even? lst))))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)
(same-parity 5)

;; 開始: 2026-08-23(Sun) 21:16:52
;; 終了: 2026-08-23(Sun) 21:25:58

#lang racket
(require racket/trace)

;; 問題2.7
;; Alyssa の区間演算のプログラムは、区間の抽象の実装を
;; 指定していないので不完全である。
;; 区間のコンストラクタの定義は以下の通りである。
;;
;;   (define (make-interval a b) (cons a b))
;;
;; 選択子 upper-bound と lower-bound を定義して、実装を完成させよ。

;; 問題文で与えられた定義
(define (make-interval a b) (cons a b))

;; TODO: lower-bound を定義する
(define (lower-bound interval) (car interval))

;; TODO: upper-bound を定義する
(define (upper-bound interval) (cdr interval))

;; chapter2.1.4.rktからコピー
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval
    x
    (make-interval (/ 1.0 (upper-bound y))
                   (/ 1.0 (lower-bound y)))))

;; TODO: 動作を確認する
(define i1 (make-interval 6.12 7.48))
(define i2 (make-interval 4.465 4.935))

(add-interval i1 i2)
(mul-interval i1 i2)
(div-interval i1 i2)

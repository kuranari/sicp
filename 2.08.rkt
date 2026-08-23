;; 開始: 2026-08-23(Sun) 21:26:18
;; 終了: 2026-08-23(Sun) 21:35:35

#lang racket
(require racket/trace)

;; 問題2.8
;; 2つの区間の差がどのように計算されるかを、Alyssa の加算の場合と
;; 同様に推論して説明せよ。
;; 対応する減算手続き sub-interval を定義せよ。

;; 2.07.rktからコピー
(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))

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

;; TODO: 差の下限と上限がどうなるかをコメントで説明する
; (区間x - 区間y) の計算をする場合
; - 上限(差が最も大きい): xの上限 - yの下限
; - 下限(差が最も小さい): xの下限 - yの上限
;; TODO: sub-interval を定義する

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))


(define i1 (make-interval 6.12 7.48))
(define i2 (make-interval 4.465 4.935))

(sub-interval i1 i2)

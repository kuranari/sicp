;; 開始: 2026-08-31(Mon) 21:51:09
;; 終了: 2026-08-31(Mon) 22:13:01

#lang racket
(require racket/trace)

;; 問題2.10
;; Ben Bitdiddle は専門のシステムプログラマとして Alyssa の肩越しに覗き込む。
;; Alyssa は 0 をまたぐ区間で割ったらどうなるか分かっていない、と Ben は指摘する。
;;
;; Alyssa のコードを修正して、その状況をチェックし、
;; 0 をまたぐ区間で割ろうとした場合にエラーを通知するようにせよ。

;; 2.09.rktからコピー
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

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (width interval)
  (/ (- (upper-bound interval) (lower-bound interval)) 2))

;; 修正前の div-interval の挙動
; [1,1] / [-1,2]の計算をする場合、実際の値は下記になる。
; y        1/y
; -1       -1.0
; -0.5     -2.0
; -0.1     -10.0
; -0.001   -1000.0
; 0.001    1000.0
; 0.1      10
; 0.5      2.0
; 2        0.5
; つまり [-∞, -1.0] U [0.5, ∞] が結果となる。
; 一方で、区間演算の結果は
; '(-1.0 . 0.5)
; となり、絶対に取り得ない範囲が答えとなる。

;; TODO: div-interval を修正し、0 をまたぐ区間で割る場合にエラーにする
(define (div-interval x y)
  (if (<= (* (lower-bound y) (upper-bound y)) 0)
      (error "yの区間が0を跨いでいます" y)
      (mul-interval
       x
       (make-interval (/ 1.0 (upper-bound y))
                      (/ 1.0 (lower-bound y))))))

;; TODO: 動作を確認する
(define i1 (make-interval 1 1))
(define i2 (make-interval -2 1))
(div-interval i1 i2)

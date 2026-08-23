;; 開始: 2026-08-23(Sun) 21:36:08
;; 終了: 2026-08-23(Sun) 22:14:57

#lang racket
(require racket/trace)

;; 問題2.9
;; 区間の「幅 (width)」を、上限と下限の差の半分と定義する。
;; 幅は、その区間が表す値の曖昧さの大きさを表す。
;;
;; 加算 (と減算) については、2つの区間の和の幅が
;; 加算される区間の幅だけの関数になることを示せ。
;;
;; 乗算と除算については、そうならないことを例で示せ。
;; (幅が同じでも、積の幅が異なるような区間の組を挙げればよい)

;; 2.08.rktからコピー
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

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

;; TODO: width を定義する
(define (width interval)
  (/ (- (upper-bound interval) (lower-bound interval)) 2))

(define i1 (make-interval 9 11))
(define i2 (make-interval 18 22))

(display "width i1: ")
(width i1)

(display "width i2: ")
(width i2)

;; TODO: 加算の幅が入力の幅だけで決まることを、コメントで説明する
; □加算
; 区間x, yの上限をx_u, y_u, 下限をx_l, y_lとする。
; 区間x, yの幅をx_w, y_wとする。
; この時
; x_w = (x_u - x_l) / 2
; y_w = (y_u - y_l) / 2
; が成り立つ。
; 区間x, yの加算の結果をzとして、その上限をz_u, 下限をz_l, 幅を z_wとすると
; z_u = x_u + y_u
; z_l = x_l + y_l
; z_w = (x_u + y_u - x_l - y_l) / 2
; となる。
; この時、
; z_w = (x_u - x_l) / 2 + (y_u - y_l) / 2
; と式変形できるため、z_w = x_w + y_w が示せる。

; □減算
; 加算と同様に x_u, x_l, y_u, y_l, x_w, y_w を定義する。
; 区間x, yの減算の結果をzとして、その上限をz_u, 下限をz_l, 幅を z_wとすると
; z_u = x_u - y_l
; z_l = x_l - y_u
; z_w = (z_u - z_l) / 2
;     = (x_u - y_l - x_l + y_u) / 2
;     = (x_u - x_l) / 2 + (y_u - y_l) / 2
;     = x_w + y_w

(width (add-interval i1 i2))
(width (sub-interval i1 i2))

;; TODO: 乗算・除算では成り立たないことを示す例を挙げる

(define i3 (make-interval 99 101))
(define i4 (make-interval 98 102))

; i1とi3は幅1, i2とi4は幅2だが、それぞれの演算後の幅は異なる
(display "width(mul): i1 i2")
(width (mul-interval i1 i2))
(display "width(mul): i3 i4")
(width (mul-interval i3 i4))

(display "width(div): i1 i2")
(width (div-interval i1 i2))
(display "width(div): i3 i4")
(width (div-interval i3 i4))

;; 開始: 2026-09-04(Fri) 20:54:17
;; 終了: 2026-09-04(Fri) 21:07:49

#lang racket
(require racket/trace)

;; 問題2.15
;; 別のユーザ Eva Lu Ator も、区間の計算式によって答えが違うことに気づいた。
;; 彼女は、誤差を持つ数を表す変数が繰り返し現れない式で計算した方が、
;; より狭い（誤差の小さい）区間が得られると主張する。
;; したがって、並列抵抗の計算には par1 よりも par2 の方が「良いプログラム」だという。
;;
;; 彼女は正しいか。理由を述べよ。

;; 2.14.rktからコピー
(define (make-interval a b)
  (if (> a b) (cons b a) (cons a b)))

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (<= (* (lower-bound y) (upper-bound y)) 0)
      (error "yの区間が0を跨いでいます" y)
      (mul-interval
       x
       (make-interval (/ 1.0 (upper-bound y))
                      (/ 1.0 (lower-bound y))))))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c w)
  (make-interval (- c (* c (/ w 100.0))) (+ c (* c (/ w 100.0)))))

(define (percent i)
  (* 100.0 (/ (width i) (center i))))

(define (show-center-percent i)
  (display (center i))
  (display "±")
  (display (percent i))
  (newline))

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

;; TODO: Eva の主張が正しいかどうか、理由とともにコメントで論じる
; 主張は正しい。なぜなら、誤差を持つ変数が複数回出ると、その分だけ誤差が広がることがあるからである。

(define A (make-center-percent 100.0 10))
(show-center-percent (div-interval A A))

; 例えば A/A は 1 になるはずだが、区間演算ではそうならない。
; 分子の A と分母の A が同じ値であるという情報が失われ、
; たまたま同じ範囲を持つ2つの独立した量として計算されるからである。

;; TODO: 主張を裏付ける（あるいは反証する）実験を書く
; x^2 / x を計算する。約分をせずに評価した場合
(show-center-percent (div-interval (mul-interval A A) A))
; -> 104.04040404040404±29.223300970873794

; 約分後に評価した場合
(show-center-percent A)
; -> 100.0±10.0

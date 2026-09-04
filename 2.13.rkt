;; 開始: 2026-09-04(Fri) 15:53:28
;; 終了: 2026-09-04(Fri) 16:44:17

#lang racket
(require racket/trace)

;; 問題2.13
;; パーセント誤差が小さいと仮定すると、2つの区間の積のパーセント誤差を
;; それぞれの因子のパーセント誤差から求める簡単な近似式が存在することを示せ。
;; 問題を簡単にするため、すべての数は正であると仮定してよい。

;; 2.12.rktからコピー
(define (make-interval a b)
  (if (> a b) (cons b a) (cons a b)))

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c w)
  (make-interval (- c (* c (/ w 100.0))) (+ c (* c (/ w 100.0)))))

(define (percent i)
  (* 100.0 (/ (width i) (center i))))

;; TODO: 積のパーセント誤差の近似式を導出し、コメントとして記述する
; 2つの区間の中央値とパーセント誤差を A±a, B±b とする。
; この時、上限は
; A+Aa = A(1+a)
; B+Bb = B(1+b)
; 下限は
; A-Aa = A(1-a)
; B-Bb = B(1-b)
; と表せる。
; 積の区間は
; 上限
; A(1+a)*B(1+b)
; = AB(1+(a+b)+ab)
; 下限
; A(1-a)*B(1-b)
; = AB(1-(a+b)+ab)
; a, bが十分に小さい場合は ab は無視できるため
; 上限: AB(1+(a+b))
; 下限: AB(1-(a+b))
; となるため、パーセント誤差は a+b と近似できる。

;; TODO: 導出した近似式が正しいことを、実際の値と比較して確認する
(define (mul-interval-approx x y)
  (make-center-percent
   (* (center x) (center y))
   (+ (percent x) (percent y))))

(define i1 (make-center-percent 100.0 0.2))
(define i2 (make-center-percent 200.0 0.3))
(define ans1 (mul-interval i1 i2))
(println (center ans1))
(println (percent ans1))

(define ans2 (mul-interval-approx i1 i2))
(println (center ans2))
(println (percent ans2))

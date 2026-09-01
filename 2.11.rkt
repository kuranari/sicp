;; 開始: 2026-09-01(Tue) 21:34:32
;; 終了: 2026-09-01(Tue) 22:26:53

#lang racket
(require racket/trace)

;; 問題2.11
;; Ben は「符号を調べれば mul-interval は9つの場合に分けられ、
;; そのうち2回より多くの掛け算が必要なのは1つだけだ」と指摘する。
;;
;; この指摘に基づいて mul-interval を書き直せ。
;;

;; 2.10.rktからコピー
(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (width interval)
  (/ (- (upper-bound interval) (lower-bound interval)) 2))

;; 比較用の元の実装
(define (mul-interval-old x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

;; TODO: 符号で場合分けした mul-interval を定義する
; [下限, 上限] x [下限, 上限] のそれぞれに対して正負を考えると 2^4 = 16通りとなる
; このうち [下限: プラス, 上限: マイナス] は区間として不適切のため、それを除くと 9通り となる
; それぞれに対して、場合分けをした演算を定義する。
(define (mul-interval x y)
  (let ((l1 (lower-bound x))
        (u1 (upper-bound x))
        (l2 (lower-bound y))
        (u2 (upper-bound y)))
    (cond
      ; 1
      ((and (> l1 0) (> u1 0) (> l2 0) (> u2 0))
       (make-interval (* l1 l2) (* u1 u2)))
      ; 2
      ((and (> l1 0) (> u1 0) (<= l2 0) (> u2 0))
       (make-interval (* u1 l2) (* u1 u2)))
      ; 3
      ((and (> l1 0) (> u1 0) (<= l2 0) (<= u2 0))
       (make-interval (* u1 l2) (* l1 u2)))
      ; 4
      ((and (<= l1 0) (> u1 0) (> l2 0) (> u2 0))
       (make-interval (* l1 u2) (* u1 u2)))
      ; 5
      ((and (<= l1 0) (> u1 0) (<= l2 0) (> u2 0))
       (make-interval (min (* l1 u2) (* l2 u1)) (max (* l1 l2) (* u1 u2))))
      ; 6
      ((and (<= l1 0) (> u1 0) (<= l2 0) (<= u2 0))
       (make-interval (* u1 l2) (* l1 l2)))
      ; 7
      ((and (<= l1 0) (<= u1 0) (> l2 0) (> u2 0))
       (make-interval (* l1 u2) (* u1 l2)))
      ; 8
      ((and (<= l1 0) (<= u1 0) (<= l2 0) (> u2 0))
       (make-interval (* l1 u2) (* l1 l2)))
      ; 9
      ((and (<= l1 0) (<= u1 0) (<= l2 0) (<= u2 0))
       (make-interval (* u1 u2) (* l1 l2))))))

;; TODO: mul-interval-old と結果が一致することを確認する
; 1
(displayln "1")
(mul-interval-old (make-interval 0.01 100.0) (make-interval 0.01 100.0))
(mul-interval     (make-interval 0.01 100.0) (make-interval 0.01 100.0))

; 2
(displayln "2")
(mul-interval-old (make-interval 0.01 100.0) (make-interval -0.01 100.0))
(mul-interval     (make-interval 0.01 100.0) (make-interval -0.01 100.0))

; 3
(displayln "3")
(mul-interval-old (make-interval 0.01 100.0) (make-interval -100.0 -0.01))
(mul-interval     (make-interval 0.01 100.0) (make-interval -100.0 -0.01))

; 4
(displayln "4")
(mul-interval-old (make-interval -0.01 100.0) (make-interval 0.01 100.0))
(mul-interval     (make-interval -0.01 100.0) (make-interval 0.01 100.0))

; 5
(displayln "5-1")
(mul-interval-old (make-interval -0.01 100.0) (make-interval -0.01 100.0))
(mul-interval     (make-interval -0.01 100.0) (make-interval -0.01 100.0))

(displayln "5-2")
(mul-interval-old (make-interval -0.01 100.0) (make-interval -10000.0 100.0))
(mul-interval     (make-interval -0.01 100.0) (make-interval -10000.0 100.0))

(displayln "5-3")
(mul-interval-old (make-interval -10000.0 10.0) (make-interval -1.0 100.0))
(mul-interval     (make-interval -10000.0 10.0) (make-interval -1.0 100.0))

; 6
(displayln "6")
(mul-interval-old (make-interval -0.01 100.0) (make-interval -100.0 -0.01))
(mul-interval     (make-interval -0.01 100.0) (make-interval -100.0 -0.01))

; 7
(displayln "7")
(mul-interval-old (make-interval -100.0 -0.01) (make-interval 0.01 100.0))
(mul-interval     (make-interval -100.0 -0.01) (make-interval 0.01 100.0))

; 8
(displayln "8")
(mul-interval-old (make-interval -100.0 -0.01) (make-interval -0.01 100.0))
(mul-interval     (make-interval -100.0 -0.01) (make-interval -0.01 100.0))

; 9
(displayln "9")
(mul-interval-old (make-interval -100.0 -0.01) (make-interval -100.0 -0.01))
(mul-interval     (make-interval -100.0 -0.01) (make-interval -100.0 -0.01))

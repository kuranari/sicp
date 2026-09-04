;; 開始: 2026-09-04(Fri) 16:45:03
;; 終了: 2026-09-04(Fri) 17:54:22

#lang racket
(require racket/trace)

;; 問題2.14
;; Lem E. Tweakit は、区間演算のシステムが式の書き方によって
;; 異なる答えを出すことに気づいた。
;; 並列抵抗の計算を代数的に等価な2つの式で書くと、以下のようになる。
;;
;;   (define (par1 r1 r2)
;;     (div-interval (mul-interval r1 r2)
;;                   (add-interval r1 r2)))
;;
;;   (define (par2 r1 r2)
;;     (let ((one (make-interval 1 1)))
;;       (div-interval one
;;                     (add-interval (div-interval one r1)
;;                                   (div-interval one r2)))))
;;
;; Lem の言うことが正しいことを示せ。
;; さまざまな算術式についてこのシステムの振る舞いを調べよ。
;; 2つの区間 A, B を作り、A/A と A/B を計算してみるとよい。

;; 2.12.rktからコピー
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

;; 問題文で与えられた定義
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

;; TODO: 区間 A, B を作り、par1 と par2 の結果を比較する
(define (show-center-percent i)
  (display (center i))
  (display "±")
  (display (percent i))
  (newline))

(define A (make-center-percent 100.0 10))
(define B (make-center-percent 200.0 50))
(show-center-percent (par1 A B))
(show-center-percent (par2 A B))

;; TODO: A/A と A/B を計算して、その結果を観察する
(displayln "A/A と A/B を計算")
(show-center-percent (div-interval A A))
(show-center-percent (div-interval A B))

; A±a/B±bを計算すると、演算結果のパーセント誤差は a+b となる？
; par2は割り算の分子の幅が常に0のため精度が保たれる。par1は分母分子のパーセント誤差が加算されるように見える

;; TODO: なぜこのようなことが起こるのか、考察をコメントとして記述する
; 区間A: [A(1-a), A(1+a)]
; 区間B: [B(1-b), B(1+b)]
; A/B の結果は
; 下限: A(1-a) / B(1+b) = A/B * (1-a) / (1+b)
; 上限: A(1+a) / B(1-b) = A/B * (1+a) / (1-b)
; 上限と下限の分母を合わせるために、下限の分母分子に(1-b)、上限の分母分子に(1+b)をかける
; 下限: A/B * (1-(a+b)+ab)/(1-b^2)
; 上限: A/B * (1+(a+b)+ab)/(1-b^2)
; 共通因子 k = (A/B)/(1-b^2) とおく
; 下限 = k(1-(a+b)+ab)
; 上限 = k(1+(a+b)+ab)

; center = (上限+下限)/2
; = k(1+ab)
; width = (上限-下限)/2
; = k(a+b)
; percent = width / center
; = (a+b)/(1+ab)

; パーセント誤差として上記の誤差が累積する。

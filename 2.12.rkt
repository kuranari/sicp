;; 開始: 2026-09-02(Wed) 22:43:26
;; 終了: 2026-09-02(Wed) 23:00:40

#lang racket
(require racket/trace)

;; 問題2.12
;; 区間を中心値と幅で表すこともできる。
;; Alyssa は以下のコンストラクタと選択子を定義した。
;;
;;   (define (make-center-width c w)
;;     (make-interval (- c w) (+ c w)))
;;   (define (center i)
;;     (/ (+ (lower-bound i) (upper-bound i)) 2))
;;   (define (width i)
;;     (/ (- (upper-bound i) (lower-bound i)) 2))
;;
;; 技術者は区間を、中心値とパーセント誤差で表すことを好む。
;; 中心値と誤差パーセントを受け取るコンストラクタ make-center-percent と、
;; パーセント誤差を返す選択子 percent を定義せよ。
;; (center 選択子は上記のものをそのまま使う)

;; 2.11.rktからコピー
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

;; 問題文で与えられた定義
(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

;; TODO: make-center-percent を定義する
(define (make-center-percent c w)
  (make-interval (- c (* c (/ w 100.0))) (+ c (* c (/ w 100.0)))))

;; TODO: percent を定義する
(define (percent i)
  (* 100.0 (/ (width i) (center i))))

;; TODO: 動作を確認する
(define i1 (make-center-percent 100 5))
(displayln i1)
(percent i1)
(define i2 (make-center-percent 5 10))
(displayln i2)
(percent i2)
(define i3 (make-center-percent -100 5))
(displayln i3)

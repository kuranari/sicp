;; 開始: 2026-08-16(Sun) 06:34:41
;; 終了: 2026-08-16(Sun) 06:52:53

#lang racket
(require racket/trace)

;; 問題2.2
;; 平面上の線分を表現する問題を考える。
;; 線分は始点と終点の2つの点で表現される。
;; 点に対するコンストラクタ make-point とセレクタ x-point, y-point、
;; 線分に対するコンストラクタ make-segment とセレクタ start-segment, end-segment
;; を定義せよ。
;;
;; さらに、これらのセレクタとコンストラクタを使って、
;; 線分の中点（両端の座標の平均を座標に持つ点）を取る手続き midpoint-segment を定義せよ。
;;
;; 点を表示する print-point は以下を使うとよい。
;;   (define (print-point p)
;;     (newline)
;;     (display "(")
;;     (display (x-point p))
;;     (display ",")
;;     (display (y-point p))
;;     (display ")"))

;; chapter1.3.3.rktからコピー
(define (average x y) (/ (+ x y) 2))

;; TODO: 点 (point) のコンストラクタとセレクタを実装する
(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define p (make-point 1 2))
(x-point p)
(y-point p)

;; TODO: 線分 (segment) のコンストラクタとセレクタを実装する
(define (make-segment p1 p2)
  (cons p1 p2))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

(define s (make-segment (make-point 1 2) (make-point 3 4)))
(start-segment s)
(end-segment s)

;; TODO: midpoint-segment を実装する
(define (midpoint-segment s)
  (let ((s1 (start-segment s))
        (s2 (end-segment s)))
    (make-point (average (x-point s1) (x-point s2))
                (average (y-point s1) (y-point s2)))))

(midpoint-segment s)

;; TODO: print-point を実装する
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")"))


(print-point (midpoint-segment s))

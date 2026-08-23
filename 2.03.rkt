;; 開始: 2026-08-23(Sun) 12:59:03
;; 終了: 2026-08-23(Sun) 13:41:41

#lang racket
(require racket/trace)

;; 問題2.3
;; 平面上の長方形の表現を実装せよ。
;; 問題2.2 のコンストラクタとセレクタを使って、
;; 長方形の周囲の長さと面積を計算する手続きを定義せよ。
;;
;; さらに、長方形の別の表現を実装せよ。
;; 周囲の長さと面積を計算する手続きが、どちらの表現でも動くように
;; 適切な抽象の壁を設計できるか?

;; 2.02.rktからコピー
(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (make-segment p1 p2)
  (cons p1 p2))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")"))

;; TODO: 長方形 (rectangle) のコンストラクタとセレクタを実装する (表現その1)
;; (define (make-rectangle p1 p2)
;;   (cons p1 p2))
;; (define (start-rectangle p)
;;   (car p))
;; (define (end-rectangle p)
;;   (cdr p))


;; TODO: 周囲の長さを求める perimeter-rectangle を実装する
;; (define (width-rectangle r)
;;   (abs (- (x-point (end-rectangle r)) (x-point (start-rectangle r)))))

;; (define (height-rectangle r)
;;   (abs (- (y-point (end-rectangle r)) (y-point (start-rectangle r)))))

(define (perimeter-rectangle r)
  (+ (* 2 (width-rectangle r)) (* 2 (height-rectangle r))))

;; TODO: 面積を求める area-rectangle を実装する
(define (area-rectangle r)
  (* (width-rectangle r) (height-rectangle r)))


;; TODO: 長方形の別の表現 (表現その2) を実装し、
;;       perimeter-rectangle / area-rectangle をそのまま使えることを確認する
(define (make-rectangle point width height)
  (cons point (cons width height)))

(define (width-rectangle r)
  (car (cdr r)))

(define (height-rectangle r)
  (cdr (cdr r)))

;; (define r1 (make-rectangle (make-point 2 1) (make-point 5 2)))
(define r2 (make-rectangle (make-point 2 1) 3 1))

;; (perimeter-rectangle r1)
;; (area-rectangle r1)
(perimeter-rectangle r2)
(area-rectangle r2)

;; 開始: 2026-08-23(Sun) 16:03:58
;; 終了: 2026-08-23(Sun) 16:25:51

#lang racket
(require racket/trace)

;; 問題2.4
;; 以下は対 (pair) の手続きによる別の表現である。
;; この表現に対して、任意のオブジェクト x, y について
;; (car (cons x y)) が x を返すことを確かめよ。
;;
;;   (define (cons x y)
;;     (lambda (m) (m x y)))
;;
;;   (define (car z)
;;     (z (lambda (p q) p)))
;;
;; 対応する cdr の定義は何か。
;; (ヒント: 確かめるには 1.1.5 節の置換モデルを使うとよい)

;; 問題文で与えられた定義
(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

;; TODO: (car (cons x y)) が x になることを置換モデルで展開し、
;;       その過程をコメントとして書く

; (car (cons x y))
; (car (lambda (m) (m x y)))
; ((lambda (m) (m x y)) (lambda (p q) p))
; ((lambda (p q) p) x y)
; x

;; TODO: cdr を定義する

(define (cdr z)
  (z (lambda (p q) q)))

;; TODO: 動作を確認する
(define pair (cons 1 2))
(car pair)
(cdr pair)

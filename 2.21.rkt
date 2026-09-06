;; 開始: 2026-09-06(Sun) 11:42:19
;; 終了: 2026-09-06(Sun) 11:46:41

#lang racket
(require racket/trace)

;; 問題2.21
;; 手続き square-list は数のリストを受け取り、
;; 各要素の2乗からなるリストを返す。
;;
;; (square-list (list 1 2 3 4))
;; -> (1 4 9 16)
;;
;; 以下の square-list の定義の <??> を埋めて完成させよ。
;;
;;   (define (square-list items)
;;     (if (null? items)
;;         nil
;;         (cons <??> <??>)))
;;
;;   (define (square-list items)
;;     (map <??> <??>))

;; 1.03.rktからコピー
(define (square x) (* x x))

;; TODO: 再帰版の square-list を定義する
(define (square-list1 items)
  (if (null? items)
      '()
      (cons (square (car items)) (square-list1 (cdr items)))))

(square-list1 (list 1 2 3 4))

;; TODO: map版の square-list を定義する
(define (square-list2 items)
  (map square items))

(square-list2 (list 1 2 3 4))

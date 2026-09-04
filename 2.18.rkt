;; 開始: 2026-09-04(Fri) 22:59:29
;; 終了: 2026-09-04(Fri) 23:37:02

#lang racket
(require racket/trace)

;; 問題2.18
;; リストを受け取り、同じ要素を逆順に並べたリストを返す
;; 手続き reverse を定義せよ。
;;
;; (reverse (list 1 4 9 16 25))
;; -> (25 16 9 4 1)

;; TODO: reverse を定義する
(define squares (list 1 4 9 16 25))
(define (append list1 list2)
  (if (null? list1) list2 (cons (car list1) (append (cdr list1) list2))))

(define (reverse1 items)
  (if (null? items) items (append (reverse (cdr items)) (list (car items)))))

(define (reverse2 items)
  (define (reverse-iter items ans)
    (if (null? items) ans (reverse-iter (cdr items) (cons (car items) ans))))
  (reverse-iter items '()))

(reverse1 squares)
(reverse2 squares)

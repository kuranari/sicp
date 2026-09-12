;; 開始: 2026-09-12(Sat) 21:25:25
;; 終了: 2026-09-12(Sat) 21:29:54

#lang racket
(require racket/trace)

;; 問題2.26
;; 次の定義があるとする。
;;
;;   (define x (list 1 2 3))
;;   (define y (list 4 5 6))
;;
;; 以下の各式を評価したとき、インタプリタが印字する結果を示せ。
;;
;;   (append x y)
;;   (cons x y)
;;   (list x y)

;; chapter2.2.1.rktからコピー
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))


(define x (list 1 2 3))
(define y (list 4 5 6))

; TODO: append を確認
; 予想: '(1 2 3 4 5 6)
(append x y)

; TODO: cons を確認
; 予想: '(1 2 3 (4 5 6))
; 結果: '((1 2 3) 4 5 6)
; → cons でフラットなリストを作るには 先頭はアトム、末尾はリストにする必要がある
; 予想は、リストの末尾にリストを追加する操作と解釈してしまっていた。
(cons x y)

; TODO: list を確認
; 予想: '((1 2 3) (4 5 6))
(list x y)

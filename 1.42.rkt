;; 開始: 2026-08-14(Fri) 21:11:02
;; 終了: 2026-08-14(Fri) 21:13:46

#lang racket
(require racket/trace)

;; 問題1.42
;; f と g を1引数の関数とする。
;; 「f の後に g」の合成 (composition) は x |-> f(g(x)) で定義される。
;; 合成を実装する手続き compose を定義せよ。
;; 例えば inc が引数に1を足す手続きだとすると、
;;   ((compose square inc) 6)
;; は 49 を返す。

;; chapter1.3.1.rktからコピー
(define (inc n) (+ n 1))

;; chapter1.2.4.rktからコピー
(define (square x) (* x x))

;; compose を実装する
(define (compose f g)
  (lambda (x) (f (g x))))

((compose square inc) 6)

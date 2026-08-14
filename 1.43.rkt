;; 開始: 2026-08-14(Fri) 21:14:04
;; 終了: 2026-08-14(Fri) 21:32:24

#lang racket
(require racket/trace)

;; 問題1.43
;; f が数値関数、n が正の整数のとき、f の n 回の繰り返し適用
;;   x |-> f(f(...(f(x))...))
;; を作ることができる。
;; f を計算する手続きと正の整数 n を入力として受け取り、
;; f の n 回繰り返し適用を計算する手続きを返す手続き repeated を書け。
;;   ((repeated square 2) 5)
;; は 625 を返す。
;; ヒント: 問題1.42の compose を使うとよい。

;; chapter1.3.1.rktからコピー
(define (inc n) (+ n 1))

;; chapter1.2.4.rktからコピー
(define (square x) (* x x))

;; 1.42.rktからコピー
(define (compose f g)
  (lambda (x) (f (g x))))

;; repeated を実装する
(define (repeated f n)
  (if (= n 0) (lambda (x) x) (compose f (repeated f (- n 1)))))

((repeated inc 4) 1)
((repeated square 2) 5)

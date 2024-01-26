;; 開始: 2021-08-29(Sun) 21:57:23
;; 終了: 2021-08-29(Sun) 22:19:06

#lang racket
(require racket/trace)

(define (f g) (g 2))
(define (square x) (* x x))
(f square)

(f (lambda (x) (+ x 3)))


;; 挙動の候補
;; 1. undefinedエラー
;; 2. 無限ループ
;; 3. (2 2)を実行した際と同じエラーが発生する


;; 無限ループになるような関数呼び出し(再帰的に自分を呼び出す)
(define (a) (a))
;; 定義エラーになる変数定義
;; (define b b)
;; 今回の問題ではf自体は定義できているから、undefinedエラーは発生しなさそう

;; 実行時の実際の展開の挙動を予想してみる
;; (define (f g) (g 2))

;; (f f)
;; = (f (lambda g) (g 2))
;; = ((lambda g) (g 2) 2)
;; = (2 2)
;; → (2 2)を実行した際と同じ、2は手続きではないという旨のエラーが発生する

(f f)
; application: not a procedure;
;  expected a procedure that can be applied to arguments
;   given: 2
; → 予想が当たっていた！

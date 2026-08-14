;; 開始: 2026-08-14(Fri) 20:43:37
;; 終了: 2026-08-14(Fri) 21:10:26

#lang racket
(require racket/trace)

;; 問題1.41
;; 引数を1つ取る手続き double を定義せよ。
;; double は「引数として与えられた手続きを2回適用する手続き」を返す。
;; 例えば inc が引数に1を足す手続きだとすると、
;;   ((double inc) 5)
;; は 7 を返す。
;; 次の式が返す値は何か。
;;   (((double (double double)) inc) 5)

;; chapter1.3.1.rktからコピー
(define (inc n) (+ n 1))

;; double を実装する
(define (double f)
  (lambda (x) (f (f x))))

;; ((double inc) 1)
(((double (double double)) inc) 5)

;; +8の処理になると予想したが、実際には+16の処理だった

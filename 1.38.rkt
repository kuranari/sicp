;; 開始: 2026-08-14(Fri) 15:46:00
;; 終了: 2026-08-14(Fri) 15:59:33

#lang racket
(require racket/trace)

;; 問題1.38
;; 1737年、オイラーは論文 "De Fractionibus Continuis" を発表し、その中で
;; e - 2 の連分数展開を示した (e は自然対数の底)。
;; この展開では Ni はすべて 1 であり、Di は順に
;;
;;   1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ...
;;
;; となる。問題1.37の cont-frac 手続きを使い、このオイラーの展開に基づいて
;; e を近似するプログラムを書け。

;; 1.37.rktからコピー
(define (cont-frac n d k)
  (define (cont-frac-i n d i)
    (if (= i k) (/ (n i) (d i)) (/ (n i) (+ (d i) (cont-frac-i n d (+ i 1))))))
  (cont-frac-i n d 1))

;; Di を返す手続きを実装する
(define (d i)
  (if (= (modulo i 3) 2) (* (+ (quotient i 3) 1) 2) 1))

;; cont-frac を使って e を近似する
(displayln (exp 1))
(displayln (+ (cont-frac (lambda (i) 1) d 10) 2.0))

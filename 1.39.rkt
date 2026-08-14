;; 開始: 2026-08-14(Fri) 16:48:59
;; 終了: 2026-08-14(Fri) 17:08:39

#lang racket
(require racket/trace)

;; 問題1.39
;; J.H. Lambert は 1770 年に、正接関数の連分数展開を発表した。
;;
;;   tan x = x / (1 - x^2 / (3 - x^2 / (5 - ...)))
;;
;; ここで x はラジアンである。問題1.37の cont-frac 手続きを使って
;; tan x を近似する手続き (tan-cf x k) を定義せよ。k は問題1.37と同様、
;; 計算する項数を指定する。

;; 1.37.rktからコピー
(define (cont-frac n d k)
  (define (cont-frac-i n d i)
    (if (= i k) (/ (n i) (d i)) (/ (n i) (+ (d i) (cont-frac-i n d (+ i 1))))))
  (cont-frac-i n d 1))

;; tan-cf を実装する

(define (tan-cf x k)
  (define (n i)
    (if (= i 1) x (- (* x x))))
  (define (d i) (- (* i 2) 1))
  (cont-frac n d k))

(tan 0)
(tan (/ pi 4))
(tan (/ pi 8))

(tan-cf 0 10)
(tan-cf (/ pi 4) 10)
(tan-cf (/ pi 8) 10)

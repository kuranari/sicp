;; 開始: 2026-08-11(Tue) 23:45:15
;; a. 終了: 2026-08-12(Wed) 00:29:59
;; b. 開始: 2026-08-12(Wed) 09:40:14
;; b. 終了: 2026-08-12(Wed) 09:52:40

#lang racket
(require racket/trace)

;; 問題1.37
;; a. 無限連分数 (continued fraction) は次の形の式である。
;;
;;      f = N1 / (D1 + N2 / (D2 + N3 / (D3 + ...)))
;;
;;    Ni, Di をすべて 1 とすると、この無限連分数は 1/φ (φ は黄金比) に収束する。
;;    連分数を有限の k 項で打ち切った近似
;;
;;      N1 / (D1 + N2 / (... + Nk / Dk))
;;
;;    を計算する手続き (cont-frac n d k) を書け。n, d は引数 i を取る手続きで、
;;    それぞれ Ni, Di を返す。
;;    Ni = Di = 1 として cont-frac を呼び出し、1/φ の値を近似せよ。
;;    小数点以下 4 桁の精度を得るには k をどのくらい大きくすればよいか。
;;
;; b. 上で書いた cont-frac が再帰的プロセスを生成するなら反復的プロセスを生成するものを、
;;    反復的なら再帰的なものを書け。

;; TODO: a. cont-frac を実装し、1/φ を近似する。4 桁の精度に必要な k を調べる

(define (cont-frac n d k)
  (define (cont-frac-i n d i)
    (if (= i k) (/ (n i) (d i)) (/ (n i) (+ (d i) (cont-frac-i n d (+ i 1))))))
  (cont-frac-i n d 1))

;; 真の値
(display (/ 1 (/ (+ 1 (sqrt 5)) 2)))
(newline)

(for ([k (in-range 1 15)])
  (display k)(display ": ")
  (display (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) k))
  (newline))

;; TODO: b. もう一方のプロセス (反復的 / 再帰的) を生成する版を実装する

(define (cont-frac2 n d k)
  (define (cont-frac-iter n d i m)
    (if (= i 0)
        m
        (cont-frac-iter n d (- i 1) (/ (n i) (+ (d i) m)))))
  (cont-frac-iter n d k 0))


(for ([k (in-range 1 15)])
  (display k)(display ": ")
  (display (cont-frac2 (lambda (i) 1.0) (lambda (i) 1.0) k))
  (newline))

;; 開始: 2021-07-27(Tue) 22:03:11
;; 終了: 2021-07-27(Tue) 22:48:12

#lang racket
(require racket/trace)

;; 正規順序評価: “完全に展開してから簡約する” ⽅法
;; 適⽤順序評価: “引数を評価してから適⽤する” ⽅法

(define (gcd a b)
  (if (= b 0) a (gcd b (remainder a b))))

(trace gcd)
(gcd 206 40)

;; 適用順序評価
;; (gcd 206 40)
;; (gcd 40 6)
;; (gcd 6 4)
;; (gcd 4 2)
;; (gcd 2 0)
;; → remainder: 4回

;; 正規順序評価
;; (gcd 206 40)
;; (gcd 40 (remainder 206 40)) ; if: 1
;; (gcd 6 (remainder 40 (remainder 206 40))) ; if: 2
;; (gcd 4 (remainder 6 (remainder 40 (remainder 206 40)))) if: 3
;; (gcd 2 (remainder 4 (remainder 6 (remainder 40 (remainder 206 40))))); if 4
;; → remainder: 10回

;; これは間違い。正規順序で評価されるのはifの述語部分のみとなるのでたとえばif: 2の行は
;; (gcd (remainder 206 40) (remainder 40 (remainder 206 40))) ; if: 2
;; となる。
;; もしLISPの遅延評価器を作ることになったらこの問題をもう一度解いてみよう

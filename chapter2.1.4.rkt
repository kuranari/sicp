;; 開始: 2026-08-23(Sun) 21:11:51
;; 終了: 2026-08-23(Sun) 21:16:52

#lang racket
(require racket/trace)

;; 2.1.4 拡張された例: 区間算術 (Extended Exercise: Interval Arithmetic)

;; 電気抵抗の並列合成のように、誤差を持つ値どうしの計算を扱いたい。
;; 「3.5 オーム ± 0.15」のような量を、下限と上限を持つ区間として表現する。
;;
;; 区間の演算は、結果の区間の下限と上限が
;; 元の区間から取りうる値の範囲になるように定義する。

;; TODO: 区間のコンストラクタ make-interval を定義する
;;       (選択子 lower-bound / upper-bound は問題2.7 で定義する)

;; TODO: add-interval を定義する
;;       和の下限は下限どうしの和、上限は上限どうしの和
(define (add-interval x y)
         (make-interval (+ (lower-bound x) (lower-bound y))
                         (+ (upper-bound x) (upper-bound y))))

;; TODO: mul-interval を定義する
;;       4通りの積の最小値と最大値をとる
(define (mul-interval x y)
         (let ((p1 (* (lower-bound x) (lower-bound y)))
               (p2 (* (lower-bound x) (upper-bound y)))
               (p3 (* (upper-bound x) (lower-bound y)))
               (p4 (* (upper-bound x) (upper-bound y))))
           (make-interval (min p1 p2 p3 p4)
                           (max p1 p2 p3 p4))))

;; TODO: div-interval を定義する
;;       逆数の区間を掛ける
(define (div-interval x y)
         (mul-interval
           x
           (make-interval (/ 1.0 (upper-bound y))
                           (/ 1.0 (lower-bound y)))))

;; 開始: 2026-08-14(Fri) 21:54:05
;; 終了: 2026-08-14(Fri) 22:18:31

#lang racket
(require racket/trace)

;; 問題1.45
;; 1.3.3節で、y |-> x/y の不動点を求めても平方根の計算は収束せず、
;; 平均緩和 (average damping) を1回はさむと収束することを見た。
;; 同じ方法で立方根は y |-> x/y^2 の平均緩和された変換の不動点として求まる。
;; しかし4乗根は y |-> x/y^3 の平均緩和1回では収束しない。
;; 平均緩和を2回はさむと収束する。
;;
;; 実験して、n乗根の計算に平均緩和が何回必要かを調べよ。
;; その結果をもとに、fixed-point, average-damp, repeated を使って
;; n乗根を計算する単純な手続きを作れ。

;; chapter1.3.3.rktからコピー
(define (average x y) (/ (+ x y) 2))

;; chapter1.3.3.rktからコピー
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next) next (try next))))
  (try first-guess))

;; chapter1.3.4.rktからコピー
(define (average-damp f) (lambda (x) (average x (f x))))

;; 1.42.rktからコピー
(define (compose f g)
  (lambda (x) (f (g x))))

;; 1.43.rktからコピー
(define (repeated f n)
  (if (= n 0) (lambda (x) x) (compose f (repeated f (- n 1)))))

;; TODO: 平均緩和の回数を実験で調べる
(define (nth-root-exp x n k)
  (fixed-point ((repeated average-damp k) (lambda (y) (/ x (expt y (- n 1))))) 1.0))

(nth-root-exp 2 2 1) ; 平均減衰1回
(nth-root-exp 2 3 1) ; 平均減衰1回
(nth-root-exp 2 4 2) ; 平均減衰2回
(nth-root-exp 2 5 2) ; 平均減衰2回
(nth-root-exp 2 6 2) ; 平均減衰2回
(nth-root-exp 2 7 2) ; 平均減衰2回
(nth-root-exp 2 8 3) ; 平均減衰3回
(nth-root-exp 2 15 3) ; 平均減衰3回
(nth-root-exp 2 16 4) ; 平均減衰4回
(nth-root-exp 2 31 4) ; 平均減衰4回
;; → 一般としてはn乗根の場合は (log n 2) 回平均減衰をすると収束する

;; TODO: n乗根を計算する nth-root を実装する
(define (nth-root x n)
  (fixed-point ((repeated average-damp (inexact->exact (floor (log n 2))))
                (lambda (y) (/ x (expt y (- n 1))))) 1.0))

(nth-root 2 2)
(nth-root 2 3)
(nth-root 2 4)
(nth-root 2 5)
(nth-root 2 6)
(nth-root 2 7)
(nth-root 2 8)
(nth-root 2 15)
(nth-root 2 16)
(nth-root 2 31)

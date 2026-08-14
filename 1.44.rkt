;; 開始: 2026-08-14(Fri) 21:32:48
;; 終了: 2026-08-14(Fri) 21:53:40

#lang racket
(require racket/trace)

;; 問題1.44
;; 信号の平滑化 (smoothing) の考え方は信号処理で重要である。
;; f が関数、dx が小さい数のとき、f の平滑化された関数とは
;; 点 x での値が f(x-dx), f(x), f(x+dx) の平均であるような関数である。
;;
;; 入力として f を計算する手続きを取り、
;; 平滑化された f を計算する手続きを返す手続き smooth を書け。
;;
;; さらに、n 回平滑化された関数 (n-fold smoothed function) を作るために
;; smooth を繰り返し使うと良いことがある。
;; 問題1.43の repeated と smooth を使って、
;; 任意の関数の n 回平滑化を作る方法を示せ。

;; chapter1.2.4.rktからコピー
(define (square x) (* x x))

;; 1.42.rktからコピー
(define (compose f g)
  (lambda (x) (f (g x))))

;; 1.43.rktからコピー
(define (repeated f n)
  (if (= n 0) (lambda (x) x) (compose f (repeated f (- n 1)))))

;; chapter1.3.3.rktからコピー
(define (average x y) (/ (+ x y) 2))

;; TODO: smooth を実装する
(define dx 0.1)
(define (smooth f)
  (lambda (x) (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3)))

((smooth square) 10)

;; TODO: repeated と smooth で n 回平滑化を作る
(define (n-fold-smoothed-function n)
  (repeated smooth n))

(((n-fold-smoothed-function 2) square) 10)
(((n-fold-smoothed-function 10) square) 10)

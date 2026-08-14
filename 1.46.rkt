;; 開始: 2026-08-14(Fri) 22:20:21
;; 終了: 2026-08-14(Fri) 23:08:12

#lang racket
(require racket/trace)

;; 問題1.46
;; この章で扱ったいくつかの数値計算手法は、
;; 「反復的改良 (iterative improvement)」と呼ばれる一般的な計算戦略の例である。
;; 反復的改良とは、答えの推測値から始めて、
;; それが十分良いかを調べ、十分でなければ推測値を改良して繰り返す、というもの。
;;
;; iterative-improve を書け。これは2つの手続きを引数に取る:
;;   - 推測値が十分良いかを判定する手続き
;;   - 推測値を改良する手続き
;; そして、引数として推測値を取り、十分良くなるまで改良を繰り返す手続きを返す。
;;
;; iterative-improve を使って、1.1.7節の sqrt と 1.3.3節の fixed-point を書き直せ。

;; chapter1.3.3.rktからコピー
(define (average x y) (/ (+ x y) 2))

;; TODO: iterative-improve を実装する
(define (iterative-improve close-enough? f)
  (lambda (guess)
    (define (try guess)
      (let ((next (f guess)))
        (if (close-enough? guess next) next (try next))))
    (try guess)))

;; TODO: iterative-improve を使って sqrt を書き直す
(define (sqrt x)
  (define tolerance 0.001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (improve guess)
    (average guess (/ x guess)))
  ((iterative-improve close-enough? improve) x))

(sqrt 2.0)

;; TODO: iterative-improve を使って fixed-point を書き直す
(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  ((iterative-improve close-enough? f) first-guess))

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)

;; AI的な模範解答
;; (define (iterative-improve good-enough? improve)
;;   (lambda (guess)
;;     (if (good-enough? guess)
;;         guess
;;         ((iterative-improve good-enough? improve) (improve guess)))))
;;
;; (define (sqrt x)
;;   ;; 二乗すれば呼び出し元で判断可能
;;   (define (good-enough? guess) (< (abs (- (* guess guess) x)) 0.001))
;;   (define (improve guess) (average guess (/ x guess)))
;;   ((iterative-improve good-enough? improve) 1.0))
;;
;; (define (fixed-point f first-guess)
;;   (define tolerance 0.00001)
;;   (define (good-enough? guess) (< (abs (- guess (f guess))) tolerance))
;;   ((iterative-improve good-enough? f) first-guess))

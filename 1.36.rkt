;; 開始: 2026-08-11(Tue) 23:12:30
;; 終了: 2026-08-11(Tue) 23:38:22

#lang racket
(require racket/trace)

;; 問題1.36
;; fixed-point を修正し、生成される近似値の列を (newline と display を使って) 印字するようにせよ。
;; 次に x^x = 1000 の解を、x -> log(1000)/log(x) の不動点を求めることで計算せよ。
;; (Racket の log は自然対数。) 平均緩和法を使った場合と使わない場合で、
;; それぞれ何ステップかかるかを比較せよ。
;; (注: fixed-point の初期値として 1 を使わないこと。log 1 = 0 で割り算ができなくなる。)

;; chapter1.3.4.rktからデッドコピー
(define (average x y) (/ (+ x y) 2))

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (display next)
      (newline)
      (if (close-enough? guess next) next (try next))))
  (display first-guess)
  (newline)
  (try first-guess))

;; 近似値の列を印字するように fixed-point を修正する
(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y))) 1.0))
(sqrt 2)

(display "-----")
(newline)

;; 平均緩和法なしで x^x = 1000 の解を求める
;; 10 から開始して 34 ステップ
(fixed-point (lambda (x) (/ (log 1000) (log x))) 10)

(display "-----")
(newline)

;; 平均緩和法ありで x^x = 1000 の解を求め、ステップ数を比較する
;; 10 から開始して 11 ステップ
(fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 10)

(display "-----")
(newline)

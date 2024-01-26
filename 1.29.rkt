;; 開始: 2021-08-22(Sun) 16:17:01
;; 終了: 2021-08-22(Sun) 17:35:36

#lang racket
(require racket/trace)

(define (cube x) (* x x x))
(define (inc n) (+ n 1))
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(define (simpson f a b n)
  (define (coefficient k)
    (cond ((or (zero? k) (= n k)) 1)
          ((odd? k) 4)
          (else 2)))

  (define (simpson-sum n h)
    (define (y k) (f (+ a (* k h))))
    (define (term k) (* (coefficient k) (y k)))
    (*
     (/ h 3)
     (sum term 0 inc n)))

  (simpson-sum n (/ (- b a) n)))


(simpson cube 0 1 100.0)
(integral cube 0 1 (/ 1 100.0))

(simpson cube 0 1 1000.0)
(integral cube 0 1 (/ 1 1000.0))

;; 円の方程式を使って円周率を求めてみる
(define (f x) (sqrt (- 1 (* x x))))
(* 4 (simpson f 0 1 10000))
(* 4 (integral f 0 1 (/ 1 10000)))

;; 当初ynの場合の係数を誤ってしまっており、精度が落ちていた
;; 正しく cond ((or (zero? k) (= n k)) 1) としたところ、正しい解が出せるようになった。

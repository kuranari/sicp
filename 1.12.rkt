#lang racket
(require racket/trace)

;; 1
;; 1 1
;; 1 2 1
;; 1 3 3 1
;; 1 4 6 4 1

;; 必ずn = 1まで再帰する実装
(define (pascal1 n m)
  (if (= n 1)
      (if (= m 1) 1 0)
      (+ (pascal1 (- n 1) (- m 1)) (pascal1 (- n 1) m))))

;; 各行の1番目とm番目は1であることを使う実装
;; 問題文には
;; > 三⾓形の辺の数値はすべて1で、三⾓形内部の数値は、それぞれその上にある2つの数値の合計となっている
;; とあるのでこの実装が適切であると考えている
(define (pascal2 n m)
  (cond
    ((or (< m 1) (< n m)) 0)
    ((or (= m 1) (= m n)) 1)
    (else (+ (pascal2 (- n 1) (- m 1)) (pascal2 (- n 1) m)))))

(pascal1 1 1)
(pascal1 1 2)
(pascal1 1 -1)

(pascal1 2 1)
(pascal1 2 2)

(pascal1 3 1)
(pascal1 3 2)
(pascal1 3 3)

(pascal1 4 1)
(pascal1 4 2)
(pascal1 4 3)
(pascal1 4 4)

(trace pascal1)
(pascal1 5 3)

;; https://stackoverflow.com/questions/19546115/which-lang-packet-is-proper-for-sicp-in-dr-racket

#lang sicp
(#%require racket/trace)

(define (plus1 a b)
  (if (= a 0)
      b
      (inc (plus1 (dec a) b))))

;; 再帰的プロセス
;; (+ 4 5)
;; (inc (+ 3 5))
;; (inc (inc (+ 2 5)))
;; (inc (inc (inc (+ 1 5))))
;; (inc (inc (inc (inc (+ 0 5)))))
;; (inc (inc (inc (inc 5))))
;; (inc (inc (inc 6)))
;; (inc (inc 7))
;; (inc 8)
;; 9

(define (plus2 a b)
  (if (= a 0)
      b
      (plus2 (dec a) (inc b))))

;; 反復的プロセス
;; (+ 4 5)
;; (+ 3 6)
;; (+ 2 7)
;; (+ 1 8)
;; (+ 0 9)
;; 9


(trace plus1)
(trace plus2)
(plus1 4 5)
(plus2 4 5)

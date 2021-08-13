#lang racket
(require racket/trace)

(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

;; a. 5回
;; b. 空間数: O(log a)
;; b. ステップ数: O(log a)

;; a / 3^n < 0.1
;; 10a < 3^n
;; log3 10a < n
;; n > log 10a

;; pの計算1回につきcubeが1度実行されるのみのため、空間数はステップ数に比例する

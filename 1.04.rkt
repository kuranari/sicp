#lang racket

;; b > 0 の場合は `+` 手続きが、b <= 0の場合は `-` 手続きが実行される。
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

(a-plus-abs-b 1 -3)
(a-plus-abs-b 1 3)


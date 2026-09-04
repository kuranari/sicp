;; 開始: 2026-09-04(Fri) 22:45:55
;; 終了: 2026-09-04(Fri) 22:59:10

#lang racket
(require racket/trace)

;; 問題2.17
;; 空でないリストを受け取り、その最後の要素だけを含むリストを返す
;; 手続き last-pair を定義せよ。
;;
;; (last-pair (list 23 72 149 34))
;; -> (34)

;; TODO: last-pair を定義する
(define (last-pair items)
  (if (null? (cdr items)) items (last-pair (cdr items))))

(last-pair (list 23 72 149 34))

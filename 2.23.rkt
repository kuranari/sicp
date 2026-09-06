;; 開始: 2026-09-06(Sun) 11:59:45
;; 終了: 2026-09-06(Sun) 12:09:37

#lang racket
(require racket/trace)

;; 問題2.23
;; 手続き for-each は map に似ているが、各要素に手続きを適用した結果を
;; 集めてリストにするのではなく、単に左から右へ順に適用していく。
;; 各要素に適用した結果の値は使わず、手続きは表示のような副作用のために実行される。
;;
;;   (for-each (lambda (x) (newline) (display x))
;;             (list 57 321 88))
;;
;;   57
;;   321
;;   88
;;
;; for-each の実装を与えよ。

;; （メモ）本文の for-each の戻り値は指定されていない。
;; Racket で「値を返さない」ことを表すには (void) が使える。

(define (for-each proc items)
  (cond ((null? items) (void))
        (else
         (proc (car items))
         (for-each proc (cdr items)))))

(for-each (lambda (x)
            (newline)
            (display x))
          (list 57 321 88))

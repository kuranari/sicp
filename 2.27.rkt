;; 開始: 2026-09-12(Sat) 21:29:54
;; 終了: 2026-09-12(Sat) 21:53:43

#lang racket
(require racket/trace)

;; 問題2.27
;; 問題2.18 の reverse を修正し、引数としてリストを受け取って、
;; 要素を逆順にするだけでなく、部分リストも（木として）すべて逆順にした
;; 手続き deep-reverse を作れ。
;;
;;   (define x (list (list 1 2) (list 3 4)))
;;
;;   x
;;   ((1 2) (3 4))
;;
;;   (reverse x)
;;   ((3 4) (1 2))
;;
;;   (deep-reverse x)
;;   ((4 3) (2 1))

;; 2.18.rktからコピー
(define (reverse items)
  (define (reverse-iter items ans)
    (if (null? items)
        ans
        (reverse-iter (cdr items) (cons (car items) ans))))
  (reverse-iter items '()))

;; TODO: reverseの動作を確認する

;; TODO: deep-reverse を定義する
;; メモ:
;; - reverse は list のトップレベルは逆順になるが、サブリストは逆順にならない
;; - 先頭の要素を無条件で ans のリストに追加しているのが原因だと思う。
;; - 先頭の要素が pair であれば、そのリストも reverse-deep をして、そうでなければ reverse 相当の処理をするといいのではないか
;; - サブサブリストを要素としてもつ z も定義をしておく

(define (deep-reverse items)
  (define (reverse-iter items ans)
    (if (null? items) ans
        (reverse-iter
         (cdr items)
         (cons
          (if (pair? (car items)) (deep-reverse (car items)) (car items))
          ans))))
  (reverse-iter items '()))

(define x (list (list 1 2) (list 3 4)))
x
(reverse x)
(deep-reverse x)

(define y (list (list 1 2) (list 3 4) (list 5 6)))
y
(reverse y)
(deep-reverse y)

(define z (list (list 1 2) (list 3 4) (list 5 6 (list 7 8))))
z
(reverse z)
(deep-reverse z)

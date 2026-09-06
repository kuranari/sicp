;; 開始: 2026-09-06(Sun) 11:46:41
;; 終了: 2026-09-06(Sun) 11:59:45

#lang racket
(require racket/trace)

;; 問題2.22
;; Louis Reasoner は、問題2.21 の square-list を反復的プロセスとして
;; 書き直そうとして、次のように定義した。
;;
;;   (define (square-list items)
;;     (define (iter things answer)
;;       (if (null? things)
;;           answer
;;           (iter (cdr things)
;;                 (cons (square (car things))
;;                       answer))))
;;     (iter items nil))
;;
;; しかしこの手続きは、答えのリストを望んだ順序と逆順に返してしまう。なぜか。
;;
;; そこで Louis は cons の引数を入れ替えてみた。
;;
;;   (define (square-list items)
;;     (define (iter things answer)
;;       (if (null? things)
;;           answer
;;           (iter (cdr things)
;;                 (cons answer
;;                       (square (car things))))))
;;     (iter items nil))
;;
;; これもうまくいかない。なぜか。

;; 1.03.rktからコピー
(define (square x) (* x x))

;; TODO: 反復プロセスでリストが逆順になることを確認する
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items '()))

(square-list (list 1 2 3 4))
; → '(16 9 4 1)

;; TODO: 上記の理由を説明する
;; square-list の cons は、「二乗の結果をそこまでの結果の"前に"追加する」という操作である。
;; 反復プロセスでのsquareは、先頭の値を評価しながら進むため
;; '()
;; '(1)
;; '(4 1)
;; '(9 4 1)
;; '(16 9 4 1)
;; のように、逆順になってしまう。

;; TODO: cons の引数を逆順にして起こることと、その理由を説明する
(define (square-list2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items '()))

(square-list2 (list 1 2 3 4))
; → '((((() . 1) . 4) . 9) . 16)

;; cons の引数を逆順にしたものはリストにはならない。
;; cons はリストの先頭に要素を追加する操作であるため
;; (cons 1 '()) はリスト '(1) になるが
;; (cons '() 1) は '(() . 1) とリストにはならない
;; 評価を進めて行った場合
;; (('() . 1) . 4)
;; ...
;; とリストではない構造になってしまう。

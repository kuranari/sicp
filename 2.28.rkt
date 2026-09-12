;; 開始: 2026-09-12(Sat) 21:54:19
;; 終了: 2026-09-12(Sat) 22:46:27

#lang racket
(require racket/trace)

;; 問題2.28
;; 引数として木を取り、その葉を左から右の順に並べたリストを返す
;; 手続き fringe を書け。
;;
;;   (define x (list (list 1 2) (list 3 4)))
;;
;;   (fringe x)
;;   (1 2 3 4)
;;
;;   (fringe (list x x))
;;   (1 2 3 4 1 2 3 4)

;; TODO: テストケースを考える
(define x (list (list 1 2) (list 3 4)))
(define y (list x x))
(define z (list 1 (list 2 3) (list 4 (list 5 6) 7)))


;; TODO: 手続き fringe を書く
;; メモ
;; 基本戦略
;; - 要素が nil であれば nil を返す
;; - 要素が葉であれば葉を返す。
;; - 要素がリストであれば、再起的にfringeを呼び出す
;; - car を再起的に掘る。その後cdrを再起的に掘る
;; - リストを掘りながら要素を足していくので iter 形式だと順番が逆になりそう。再帰で定義する。
;; 小さいテストケースは (fringe (list (list 1))) → '(1) 。二重カッコが消す方法を考える
;;
;; 例えば cdr が nil だったら、 (fringe car) を返すこと考える。
;; - (fringe (list (list 1 2))) のケースはそれでうまくいきそう。やってみる。
;; - リストの最後の nil まで取り除かれてしまってリストにならない
;; → 失敗
;;
;; appendを使うことを考える
;; - carがatomだったら、一度listにする必要がある
;; → 成功

;; chapter2.2.1.rktからコピー
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (fringe tree)
  (cond
    ((null? tree) '())
    ((pair? tree) (append (fringe (car tree)) (fringe (cdr tree))))
    (else (list tree))))

(fringe '())
(fringe (list 1))
(fringe (list (list 1)))

(displayln "x")
x
(fringe x)
(displayln "y")
y
(fringe y)
(displayln "z")
z
(fringe z)

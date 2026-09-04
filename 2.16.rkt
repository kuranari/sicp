;; 開始: 2026-09-04(Fri) 21:13:17
;; 終了: 2026-09-04(Fri) 22:03:33

#lang racket
(require racket/trace)

;; 問題2.16
;; 一般に、代数的に等価な式が異なる答えを導きうるのはなぜか説明せよ。
;; この欠点を持たない区間演算のパッケージを作ることはできるか。
;; それとも、それは不可能な仕事か。
;;
;; （警告: この問題は非常に難しい）

;; 2.15.rktからコピー
(define (make-interval a b)
  (if (> a b) (cons b a) (cons a b)))

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (<= (* (lower-bound y) (upper-bound y)) 0)
      (error "yの区間が0を跨いでいます" y)
      (mul-interval
       x
       (make-interval (/ 1.0 (upper-bound y))
                      (/ 1.0 (lower-bound y))))))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c w)
  (make-interval (- c (* c (/ w 100.0))) (+ c (* c (/ w 100.0)))))

(define (percent i)
  (* 100.0 (/ (width i) (center i))))

(define (show-center-percent i)
  (display (center i))
  (display "±")
  (display (percent i))
  (newline))

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

;; TODO: 代数的に等価な式が異なる答えを導く理由を、一般論としてコメントで説明する
; A/Aが1にならない例でわかるように、同一の値を示しているものが、評価器では独立した2つの量として扱われてしまう。
; 例えば除算では、上限評価する際に、分子はAの上限、分母はAの下限の値を使うように、同一の値を取るべきものが、異なった前提を取るため、代数的に等価な式であっても、導かれる値は異なるものになる。

;; TODO: この欠点を持たない区間演算パッケージが作れるか（あるいは不可能か）を論じる

; - 現在の評価器は A を即座に [90, 110] に変換し、ラベルの情報が失われる
; - これに対して式を記号的に変形してから評価することが考えられるが、等価な式が無数にあることから、最小性の判定は困難である。
; - 出現回数が最小の式を実現するためには、それに対応した演算関数を用意する必要がある。
; - 例えば x * x はxが2度出現してしまうため (sq x) のような、二乗演算を定義する必要がある
; したがって、厳密な区間演算が可能なのは、パッケージが記号的に変形できる範囲であり、
; かつ、パッケージが用意したプリミティブ演算で表現しきれる代数式に限られる。
; 任意の代数式を対象にすることは困難である。

; 区間をラベル付きの一次式 (A = 100 + 10ε1 のような形) で表す方法を考える。
; 評価器は、同じ原因で連動して動くラベルを扱うことができるようになる。
; この場合、足し算、引き算、定数倍は厳密に演算を行える (A - A は厳密に 0 になる)
; しかし、掛け算はラベルの2次の項が現れてしまう。
; 2次の項は一次式で表せないため、独立な新しいラベルに置き換えるしかない。
; その時点で「この2つは連動している」という情報が失われ、2.14 と同じ問題が再発する。

; 以上より、式を変形する方向でも、表現を変える方向でも欠点は除ききれない。
; 完全に欠点を持たない区間演算パッケージを作ることはできない。

;; 開始: 2026-09-06(Sun) 11:19:19
;; 終了: 2026-09-06(Sun) 11:23:49

#lang racket
(require racket/trace)

;; 2.2.1 列の表現 (Representing Sequences)

(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))
(define squares (list 1 4 9 16 25))
(list-ref squares 3)

(define odds (list 1 3 5 7))
(length odds)

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(append squares odds)
(append odds squares)

(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map proc (cdr items)))))

(map abs (list -10 2.5 -11.6 17))

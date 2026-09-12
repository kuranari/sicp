;; 開始: 2026-09-12(Sat) 20:44:42
;; 終了: 2026-09-12(Sat) 21:04:44

#lang racket
(require racket/trace)

;; 2.2.2 階層構造 (Hierarchical Structures)

;; chapter2.2.1.rktからコピー
(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map proc (cdr items)))))

(define x (cons (list 1 2) (list 3 4)))
(length x)

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(count-leaves x)

(length (list x x))
(count-leaves (list x x))

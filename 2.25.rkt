;; 開始: 2026-09-12(Sat) 21:04:44
;; 終了: 2026-09-12(Sat) 21:25:01

#lang racket
(require racket/trace)

;; 問題2.25
;; 次の各リストから 7 を取り出す car と cdr の組み合わせを示せ。
;;
;;   (1 3 (5 7) 9)
;;   ((7))
;;   (1 (2 (3 (4 (5 (6 7))))))

; 箱-点構造を書きながら car / cdr を記述していった
(define a (list 1 3 (list 5 7) 9))
(car (cdr (car (cdr (cdr a)))))

(define b (list (list 7)))
(car (car b))

(define c (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
(car (cdr
      (car (cdr
            (car (cdr
                  (car (cdr
                        (car (cdr
                              (car (cdr c))))))))))))

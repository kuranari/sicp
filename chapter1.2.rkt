#lang racket
(require racket/trace)

;; 再起的プロセス
;; 空間数: O(n)
;; ステップ数: O(n)
(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))))

(factorial 3)


;; 反復的プロセス
;; 空間数: 1
;; ステップ数: O(n)
(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* product counter)
                 (+ counter 1)
                 max-count)))

(define (factorial2 n)
  (fact-iter 1 1 n))

(trace factorial)
(trace fact-iter)
(factorial 6)
(factorial2 6)

;; 再帰的プロセス(process)
;; 遅延評価による膨張と、演算が実際に行われる収縮によって定義されるプロセス
;; 再帰手続き(procedure)
;; 手続き定義がその手続き自身を差す構文上の事実

;; 末尾再帰的: 再帰手続きとして記述してあっても、固定の記憶スペースで実現できる



;; 1.2.2 木構造再帰

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(fib 10)

(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))

(define (fib2 n)
  (fib-iter 1 0 n))

(fib2 10)


(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0)(= kinds-of-coins 0)) 0)
        (else (+
               (cc amount (- kinds-of-coins 1))
               (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)))))

(define (count-change amount)
  (cc amount 5))


(count-change 100)

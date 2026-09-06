;; 開始: 2026-09-05(Sat) 17:26:25
;; 中断: 2026-09-05(Sat) 17:42:36
;; 再開: 2026-09-06(Sun) 09:49:55
;; 終了: 2026-09-06(Sun) 10:15:46

#lang racket
(require racket/trace)

;; 問題2.19
;; 1.2.2 の両替の数え上げプログラムを、硬貨の種類をリストで扱えるように書き直したい。
;; 目標は次のような形で呼び出せるようにすること。
;;
;;   (define us-coins (list 50 25 10 5 1))
;;   (define uk-coins (list 100 50 20 10 5 2 1 0.5))
;;   (cc 100 us-coins)
;;   -> 292
;;
;; cc の定義を以下のように変え、
;;
;;   (define (cc amount coin-values)
;;     (cond ((= amount 0) 1)
;;           ((or (< amount 0) (no-more? coin-values)) 0)
;;           (else
;;            (+ (cc amount
;;                   (except-first-denomination coin-values))
;;               (cc (- amount
;;                      (first-denomination coin-values))
;;                   coin-values)))))
;;
;; first-denomination / except-first-denomination / no-more? を
;; リスト表現に対して定義せよ。
;;
;; また、(cc 100 us-coins) の答えは coin-values のリストの順序に影響されるか。
;; なぜそうなるのか（あるいはならないのか）。

;; chapter1.2.rktからコピー（リストを使わない元の版）
;; (define (first-denomination kinds-of-coins)
;;   (cond ((= kinds-of-coins 1) 1)
;;         ((= kinds-of-coins 2) 5)
;;         ((= kinds-of-coins 3) 10)
;;         ((= kinds-of-coins 4) 25)
;;         ((= kinds-of-coins 5) 50)))
;;
;; (define (cc amount kinds-of-coins)
;;   (cond ((= amount 0) 1)
;;         ((or (< amount 0) (= kinds-of-coins 0)) 0)
;;         (else (+
;;                (cc amount (- kinds-of-coins 1))
;;                (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)))))
;;
;; (define (count-change amount)
;;   (cc amount 5))

;; 問題文で与えられた定義
(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

;; TODO: 1.2.2 を思い出す
; - 両替の組み合わせの数を返す
; - first-denomination はコインのindexに対応する金額を返す
; cc は
; - amount が 0 であれば 1 種類を返す
; - amount が 0 以下、または、コインの種類を使い切った場合は 0 を返す
; - そうでなければ、下記の組み合わせを加算する
;     - 現在の最大の硬貨以外を使う組み合わせ
;     - 現在の最大の硬貨を1つ増やした組み合わせ

;; TODO: first-denomination を定義する
(define (first-denomination coin-values)
  (car coin-values))

;; TODO: except-first-denomination を定義する
(define (except-first-denomination coin-values)
  (cdr coin-values))

;; TODO: no-more? を定義する
(define (no-more? coin-values)
  (null? coin-values))

;; TODO: (cc 100 us-coins) が 292 になることを確認する
(cc 100 us-coins)
(cc 100 uk-coins)

;; TODO: リストの順序を変えても答えが変わらないか実験し、理由をコメントで述べる
;; cc の処理は「先頭のコインを使う場合」と「使わない場合」の組み合わせ列挙であるため、コインの順序に依存しない。
;; 計算効率は降順（大きいものから小さいものへ）の方がよい。
;; 例えば、昇順で定義した場合には、計算の過程で amount が確実に小さくなるにも関わらず、
;; コインの候補は大きくなるため、必ず候補から外れる値に対しての比較が行われるからである。
;; 大きい数から比較する方が、amountが減る量の大きさ、無駄な比較の量の小ささ、の観点で効率がいい。
;; 以下はAIと対話をした書き換え。
;; 再帰の第二の枝は、硬貨リストを変えずに amount だけを減らす。
;; 昇順では先頭が 1 なので、101通りの全てを解くことになり、降順では 100, 50, 0 の3通りで済む。
;; 先頭の硬貨が大きいほど部分問題の数を減らせるため、効率がよくなる。
(cc 100 (reverse us-coins))
(cc 100 (list 1 50 5 10 25))
(cc 100 (reverse uk-coins))

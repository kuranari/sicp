;; 開始: 2026-08-23(Sun) 17:02:18
;; 中断: 2026-08-23(Sun) 18:04:25 (ここまで 62分7秒)
;; 再開: 2026-08-23(Sun) 20:29:48
;; 終了: 2026-08-23(Sun) 21:07:07 (実作業 99分26秒)

#lang racket
(require racket/trace)

;; 問題2.6
;; 対を手続きで表現できるように、数もまた手続きで表現できる。
;; これは Church 数 (Church numerals) と呼ばれる。
;; Alonzo Church (ラムダ計算の考案者) にちなむ。
;;
;; zero と、1 を加える手続き add-1 を以下のように定義する。
;;
;;   (define zero (lambda (f) (lambda (x) x)))
;;
;;   (define (add-1 n)
;;     (lambda (f) (lambda (x) (f ((n f) x)))))
;;
;; one と two を (add-1 を使わずに) 直接定義せよ。
;; (ヒント: (add-1 zero) を置換モデルで評価せよ)
;;
;; さらに、加算手続き + を直接定義せよ
;; (add-1 の繰り返しを使わずに)。

;; 問題文で与えられた定義
(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;; TODO: (add-1 zero) を置換モデルで展開し、その過程をコメントとして書く
; (add-1 zero)
; (add-1 (lambda (f) (lambda (x) x)))

; ↓ 本当は lambda (n) で囲う必要がある
; ((lambda (f) (lambda (x) (f ((n f) x)))) (lambda (f) (lambda (x) x)))
; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
; (lambda (f) (lambda (x) (f ((lambda (x) x) x))))
; (lambda (f) (lambda (x) (f x)))

;; TODO: one を直接定義する
(define one (lambda (f) (lambda (x) (f x))))

;; TODO: two を直接定義する
;; AIと壁打ちをした結果 zero や one は直前まで展開しない方がよいということがわかった。
;; twoの定義からは、その方針を採用する
; (add-1 one)
; ((lambda (n) (lambda (f) (lambda (x) (f ((n f) x))))) one)
; (lambda (f) (lambda (x) (f ((one f) x))))
; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))
; (lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))
; (lambda (f) (lambda (x) (f (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

;; TODO: 加算手続きを直接定義する
;; AIにヒントを聞きながら実装をした。
;; - a は 「f を a 回適応する機械」
;; - b は 「f を b 回適応する機械」
(define (add a b)
  (lambda (f) (lambda (x) ((a f) ((b f) x)))))

;; TODO: 動作を確認する
;;       (Church 数は手続きなので、そのまま表示しても中身が見えない。
;;        通常の整数に変換する手続きを書くと確認しやすい)
(define (church->int n)
  ((n (lambda (x) (+ x 1))) 0))

(church->int zero)
(church->int one)
(church->int two)

(define three (add one two))
(define four (add two two))

(church->int (add three four))

;; 開始: 2021-08-13(Fri) 07:37:27
;; 終了: 2021-08-13(Fri) 07:40:11
;; 教科書を読みながら別途時間をとって考えていた

#lang racket
(require racket/trace)

;; 思考過程はノート参照
;; https://codology.net/post/sicp-solution-exercise-1-26/
;; appricative順に作用されるため、引数は全て展開してから関数本体が実行される。
;; つまり明に掛け算を実行しているものは1度のexpmod呼び出しで、2回のexpmod呼び出しが発生することになる。
;; 従って、手続きの深さはlog(n)だが、それにより呼び出しが2^nで増えるため計算のオーダーはO(log 2^n) = O(n)となる。

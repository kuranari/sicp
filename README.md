# SICP

SICP (Structure and Interpretation of Computer Programs) の学習用リポジトリです。
各ファイルは `1.01.rkt` のように章・節番号に対応しています。

## 実行方法

[Racket](https://racket-lang.org/) がインストールされている前提です。

```bash
racket <ファイル名>.rkt
```

例:

```bash
racket 1.01.rkt
```

ファイル内のトップレベルの式が順に評価され、結果が出力されます。

## REPL

引数なしで `racket` を実行すると対話的な REPL が起動します。

```bash
racket
```

ファイルを読み込んだ状態で REPL に入りたい場合は `-i -t` オプションを使います。

```bash
racket -i -t 1.01.rkt
```

REPL 内から個別のファイルを読み込むには `require` を使います。

```racket
(require "1.01.rkt")
```

## ユニットテスト

[`rackunit`](https://docs.racket-lang.org/rackunit/) を使ってテストを書けます（例: `1.03.rkt`）。
未インストールの場合は以下でセットアップします。

```bash
raco pkg install --auto rackunit-lib
```

`check-equal?` などをファイルに直接書くと、`racket <ファイル名>.rkt` を実行するだけでテストが走ります。

```racket
(require rackunit)

(check-equal? (+ 1 2) 3)
```

失敗したチェックがあれば標準エラーにレポートが出力され、終了コードが非ゼロになります。

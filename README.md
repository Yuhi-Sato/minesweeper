# Minesweeper

このプロジェクトは、シンプルなマインスイーパのゲームです。

主なロジックはRubyで書かれていますが、[ruby.wasm](https://github.com/ruby/ruby.wasm)を使用しているため、Rubyの実行環境がなくてもブラウザ上で動作します。

サーバーを立ち上げて `index.html` にアクセスすることで、ゲームをプレイできます。

## 環境

- 必須: Webサーバー（例: PythonのSimpleHTTPServer, Node.jsのhttp-server など）
- ブラウザ

## 起動方法

### Pythonを使用する場合
以下のコマンドを実行して簡易HTTPサーバーを起動し、ブラウザで `http://localhost:8000/index.html` にアクセスしてください。

```sh
python -m http.server 8000
```

### Node.jsを使用する場合
`http-server` パッケージを使用してサーバーを立ち上げることもできます。

```sh
npm install -g http-server
http-server
```

### 任意のWebサーバーを使用する場合
`index.html` が含まれるディレクトリをドキュメントルートに設定し、Webサーバーを起動してください。

## 遊び方

1. `index.html` にアクセスします。
2. マインスイーパの画面が表示されるので、セルをクリックしてプレイしてください。
3. 地雷を踏まないようにすべての安全なセルを開ければ勝利です！



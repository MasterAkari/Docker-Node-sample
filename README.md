# Docker-Node-sample

DockerでNodeサーバーを立ち上げるためのサンプル

!!! CAUTION
    * 設定スクリプトは、Windowsのみサポートしています。


## 使い方

### Windows

1. Docker Desktopをインストールしてください。
1. 下記のコマンドを実行してください。

```bash
cd ${workspaceFolder}/script/win

# イメージを作成します。
image_setup.cmd

# コンテナの作成
container_create.cmd
```

```bash
# その他

## コンテナにログインします。
container_start.cmd
container_stop.cmd

## ネットワークを作成/削除します。
network_create.cmd
network_remove.cmd

## コンテナを削除します。
container_remove.cmd
```

## 設定について

### nodeサーバーの設定について

設定については、`script/config.ini`を編集してください。

| 分類 | 設定名     | デフォルト値 | 説明                                   | Notes. |
| ---- | ---------- | ------------ | -------------------------------------- | ------ |
| WEB  | OPEN_PORT  | 2700         | ホストからNodeへ接続する際のポート番号 | --     |
| SRC  | SOURCE_DIR | ./src/public | 共有フォルダのディレクトリ             | --     |

* ホストからNodeへ接続する際のポート番号は、`OPEN_PORT`で設定してください。
* 共有フォルダ設定しているため、指定したフォルダをホストから編集することができます。


### Dockerの設定について

設定については、`script/config.ini`を編集してください。

| 分類      | 設定名                | デフォルト値  | 説明                           | Notes. |
| --------- | --------------------- | ------------- | ------------------------------ | ------ |
| Setup     | DOCKER_FILE_NAME      | dockerfile    | 実行するdockerfileファイル名   | --     |
| Setup     | DOCKER_IMAGE_NAME     | html-server   | Dockerイメージ名               | --     |
| Setup     | DOCKER_IMAGE_VER      | 0.0.1         | Dockerイメージのバージョン     | --     |
| Container | DOCKER_CONTAINER_NAME | node_server   | Docker コンテナ名              | --     |
| Container | USER_NAME             | common        | Docker実行時のユーザー名       | --     |
| Container | SERVER_PORT           | 8000          | Nodeがオープンするポート番号   | --     |
| Network   | DOCKER_NETWORK_NAME   | bridge        | Dockerネットワーク名           | --     |
| Network   | DOCKER_NETWORK_SUBNET | 172.17.0.0/16 | Dockerネットワークのサブネット | --     |
| Network   | DOCKER_NETWORK_IP     | 172.17.0.2    | IPアドレス                     | --     |

### Authors and acknowledgment

We offer heartfelt thanks to the pioneers for the invaluable gifts they've shared with us. The hardware, libraries, and tools they've provided have breathed life into our journey of development. Each line of code and innovation has woven a tapestry of brilliance, lighting our path. In this symphony of ingenuity, we find ourselves humbled and inspired. These offerings infuse our project with boundless possibilities. As we create, they guide us like stars, reminding us that collaboration can turn dreams into reality. With deep appreciation, we honor the open-source universe that nurtures us on this journey of discovery and growth.

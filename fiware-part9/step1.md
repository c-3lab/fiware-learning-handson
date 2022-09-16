Part9ではFIWAREコンポーネントのアクセス保護について学習していきます。

# 1-1 FIWAREコンポーネントのアクセス保護の必要性

適切なFIWAREコンポーネントのアクセス保護が行われていない場合、アクセス権限を持たない第三者が悪意を持ってサーバーやシステムに侵入する行為である不正アクセスが行われ、情報の漏洩や改ざんなどの被害が出る可能性があります。

これらを防ぐため、KeyrockやWilmaなどのコンポーネントを使用して、バックエンド・アプリケーションに認証および認可のセキュリティを追加し、許可されたユーザのみがOrionやRESTサービスにアクセスできるようにします。

# 1-2 KeyrockとWilmaの概要

![Keyrockの概要](./assets/9-1.png)

![Wilmaの概要](./assets/9-2.png)

# 1-3 KeyrockとWilmaの起動確認

今回は以下の構成を起動します。

![全体構成図](./assets/9-3.png)

以下のコマンドを実行します。

```
docker-compose -f fiware-part9/assets/docker-compose.yml up -d
```

ターミナルの処理が終了したら以下のコマンドで起動していることを確認します。

```
docker ps
```

一覧にfiware-orion-proxy, fiware-orion, fiware-keyrock, db-mongo, db-mysqlがあれば成功です。

# 1-4 KeyrockとWilmaの設定

手順の簡略化のため、本PartではKeyrockのGUIやAPIインターフェースを利用したユーザー、アプリケーションの登録の手順は省略しています。

docker-compose.ymlによるコンテナ起動時に、以下のデータが自動的に登録されます。

管理者ユーザー
|名前|Eメール|パスワード|
|-|-|-|
|alice|`alice-the-admin@test.com`|test|

アプリケーション
|Key|Value|
|-|-|
|Client ID|tutorial-dckr-site-0000-xpresswebapp|
|Client Secret|tutorial-dckr-site-0000-clientsecret|

# 1-5 アクセスの確認

以下のコマンドを実行し、Authorizationヘッダに指定するトークンを作成します。

※作成するトークンは`ClientID:Client Secret`をBase64エンコードした値になります

```
echo -n "tutorial-dckr-site-0000-xpresswebapp:tutorial-dckr-site-0000-clientsecret" | openssl base64 -A
```

次の手順で作成したトークンを使用するため、環境変数に作成したトークンを設定しておきます。
以下のコマンドの = 以降に先ほど作成したトークンをコピー&ペーストして実行します。

```
TOKEN=echoで表示した値
```

以下のコマンドを実行し、Keyrockからアクセストークンを取得します。

```
curl -iX POST \
  "http://localhost:3005/oauth2/token" \
  -H "Accept: application/json" \
  -H "Authorization: Basic ${TOKEN}" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  --data "username=alice-the-admin@test.com&password=test&grant_type=password"
```

![Access token](./assets/9-4.png)

次の手順でaccess_tokenを使用するため、環境変数にaccess_tokenを設定しておきます。  
以下のコマンドの = 以降に先ほど取得したaccess_tokenをコピー&ペーストして実行します。  

```
ACCESS_TOKEN=レスポンスに含まれるアクセストークン
```

以下の手順で、アクセストークンを使用したOrionへのアクセスを確認します。

1. 以下のコマンドを実行し、正しいアクセストークンを指定した場合、Orionからデータを取得できることを確認します。

  ```
  curl -X GET \
    http://localhost:1027/v2/entities \
    -H "X-Auth-Token: ${ACCESS_TOKEN}"
  ```

  空のjson配列`[]`が返ってくれば成功です。

2. 以下のコマンドを実行し、間違ったアクセストークンを指定した場合、Orionからデータが取得されないことを確認します。

```
curl -X GET \
  http://localhost:1027/v2/entities \
  -H "X-Auth-Token: bad_token"
```
`Invalid token: access token is invalid`が出力されることを確認します。

# 1-6 コンテナの停止・削除
起動したコンテナを停止・削除します。

以下コマンドでコンテナを停止・削除します。

`docker-compose -f fiware-part9/assets/docker-compose.yml down`

完了したら以下のコマンドでコンテナが停止・削除されていることを確認します。

`docker ps -a`

一覧に何も表示されていなければ成功です。

[終了](./finish.md)

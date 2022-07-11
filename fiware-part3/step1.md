Part3ではFIWARE OrionのSubscription機能について学習していきます。

# Orionの概要

![Orion概要](./assets/3-0.png)

# 1-1 FIWARE OrionとMongoDBの起動確認

今回は以下の構成が自動起動されます。  
※起動の詳細に関してはの[Part1](../fiware-part1/step1.md)または[Part2](../fiware-part2/step1.md)を参照

![全体構成図](./assets/3-8.png)

ターミナルの処理が終了したら以下のコマンドで動作確認します。

`curl localhost:1026/v2/entities | jq`

# 1-2 FIWARE OrionのSubscription機能について

FIWARE Orionにはデータの変更を検知して特定のシステムへ通知する機能があります。
**/v2/subscriptions/** へPOSTすることで通知の設定ができます。

POSTする際のbodyは以下の通りです。

![SubscriptionBody](./assets/3-3.png)

この例では**Room1**の**pressureの値**が更新されたら、通知先のURLへ**pressureのattribute**をHTTPのPOSTで送信するような設定です。

### 通知先のサンプルアプリを起動

Subscriptionの設定をする前に通知先の[FIWAREが公開しているサンプルアプリ](https://github.com/telefonicaid/fiware-orion/blob/master/scripts/accumulator-server.py)を起動します。

![Accumulate](./assets/3-4.png)

サンプルアプリを動作させるため、新しいTerminalを開きます。

![OpenMenu](./assets/3-1.png)

Open New Terminalを押します。

![OpenTerminal](./assets/3-2.png)

**Terminal2**で以下のコマンドを実行し[FIWAREが公開しているサンプルアプリ](https://github.com/telefonicaid/fiware-orion/blob/master/scripts/accumulator-server.py)を起動します。

`./fiware-part3/assets/accumulator-server.py --port 1028 --url /accumulate --pretty-print -v`

これはhttpでアクセスしてきた情報をログとして表示するサーバです。  
このアプリを使ってOrionからの通知の内容を確認していきます。


### Subscriptionの設定

**元のTerminal**に戻ります。  
以下のコマンドでSubscriptionの設定を行います。


```json
curl -v localhost:1026/v2/subscriptions -s -S -H 'Content-Type: application/json' -d @- <<EOF
{
  "description": "A subscription to get info about Room1",
  "subject": {
    "entities": [
      {
        "id": "Room1",
        "type": "Room"
      }
    ],
    "condition": {
      "attrs": ["pressure"]
    }
  },
  "notification": {
    "http": {
      "url": "http://[[HOST_SUBDOMAIN]]-1028-[[KATACODA_HOST]].environments.katacoda.com/accumulate"
    },
    "attrs": [
      "pressure"
    ]
  }
}
EOF
```


pressureの値を変更してみます。

`curl localhost:1026/v2/entities/Room1/attrs/pressure/value -s -S -H 'Content-Type: text/plain' -X PUT -d 720`

**Terminal2**を開きログを確認してみます。  
通知された結果が以下のように出力されています。

![Result](./assets/3-5.png)

# 1-2 Subscirptionの確認

**/v2/subscriptions**に対してGETすることでsubscirptionの一覧を取得できます。

`curl localhost:1026/v2/subscriptions | jq`

先ほど作成したsubscriptionにidが作成されていることが確認できます。

![subscriptionId](./assets/3-7.png)

このidを使用し **/v2/subscriptions/{id}** のように指定することで、PATCHで更新、DELETEで削除を行うことができます。

[STEP2へ](step2.md)
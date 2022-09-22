[STEP1へ](step1.md)

# 2-1 SubscriptionによるCygnusへの通知

Cygnusに履歴データを作成する方法はOrionからのSubscriptionによる通知で実現します。

以下のSubscription設定でcygnusの`/notify`へ通知するように設定します。  
`/notify`はOrionからのSubscription通知を受けて履歴ビューを作成してくれるエンドポイントになります。

```json
curl -v localhost:1026/v2/subscriptions -s -S -H 'Content-Type: application/json' -X POST -d @- <<EOF
{
  "description": "A subscription to get info about Room",
  "subject": {
    "entities": [
      {
        "idPattern": ".*",
        "type": "Room"
      }
    ],
    "condition": {
      "attrs": ["temperature"]
    }
  },
  "notification": {
    "http": {
      "url": "http://cygnus:5055/notify"
    },
    "attrs": [
      "temperature"
    ]
  }
}
EOF
```

気温が徐々に変化していったことを想定してtemperatureの値を変更してみます。

`curl localhost:1026/v2/entities/Room1/attrs/temperature/value -s -S -H 'Content-Type: text/plain' -X PUT -d 29.5`

`curl localhost:1026/v2/entities/Room1/attrs/temperature/value -s -S -H 'Content-Type: text/plain' -X PUT -d 30.0`

`curl localhost:1026/v2/entities/Room1/attrs/temperature/value -s -S -H 'Content-Type: text/plain' -X PUT -d 30.5`

`curl localhost:1026/v2/entities/Room1/attrs/temperature/value -s -S -H 'Content-Type: text/plain' -X PUT -d 30.2`

# 2-2 履歴データの確認

postgreSQL Clientを起動してデータベースに接続を行います。

`docker run -it --rm  --network assets_default jbergknoff/postgresql-client postgresql://postgres:password@postgres-db:5432/postgres`


Room1の履歴を確認してみます。

`SELECT * FROM default_service.room1_room limit 10;`

Room1の履歴を確認後、ターミナルに`exit`を入力してpostgreSQL Clientを終了させます。

# 2-3 コンテナの停止・削除

起動したコンテナを停止・削除します。

1. 以下コマンドでコンテナを停止・削除します。

   `docker-compose -f fiware-part4/assets/docker-compose.yml down`

2. 完了したら以下のコマンドでコンテナが停止・削除されていることを確認します。

   `docker ps -a`

   一覧に何も表示されていなければ成功です。

[終了](finish.md)

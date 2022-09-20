[STEP3へ](step3.md)

# 4-1 Entityの削除

1. `/v2/entities/{id}`に対してDELETEメソッドを使うことで指定したEntityを削除することができます。

   `curl localhost:1026/v2/entities/Room2 -X DELETE`

2. 削除されたことを確認します。

   `curl localhost:1026/v2/entities | jq`

## 4-2 Attributeの削除

1. `/v2/entities/{id}/attrs/{attrName}`に対してDELETEメソッドを使うことで指定したEntityを削除することができます。

   `curl localhost:1026/v2/entities/Room1/attrs/pressure -X DELETE`

2. 削除されたことを確認します。

   `curl localhost:1026/v2/entities | jq`

# 4-3 コンテナの停止・削除
起動したコンテナを停止・削除します。

1. 以下コマンドでコンテナを停止・削除します。

   `docker-compose -f fiware-part2/assets/docker-compose.yml down`

2. 完了したら以下のコマンドでコンテナが停止・削除されていることを確認します。

   `docker ps -a`

   一覧に何も表示されていなければ成功です。

[終了](finish.md)

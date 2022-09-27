[STEP1へ](step1.md)

# 2-1 FIWARE-Serviceを指定したEntityの登録

Orionでは"Fiware-Service"というHTTPヘッダーでテナント名を設定することができます。

今回登録するRoom1 Entityを確認します。

`cat fiware-part5/assets/example-ngsi-room1.json`

以下のコマンドで**tenant_a**にRoom1 Entityを登録します。

`curl localhost:1026/v2/entities -s -S -H 'Fiware-Service: tenant_a' -H 'Content-Type: application/json' -X POST -d @fiware-part5/assets/example-ngsi-room1.json`


以下のコマンドでEntity一覧を取得します。

`curl localhost:1026/v2/entities | jq`

デフォルトのテナントでは何も取得されません。

以下のコマンドでFiware-Serviceを指定して取得します。

`curl localhost:1026/v2/entities -H 'Fiware-Service: tenant_a' | jq`

Entityの更新や削除も同様にFiware-Serviceを指定して行うことができます。
また、Subscription APIなど他のAPIやOrion以外の他のコンポーネントもFiware-Serviceに対応しているものが多くあります。


# 2-2 Fiware-ServicePathによるスコープについて
Fiware-Serviceのマルチテナンシーとは別にFiware-ServicePathによってスコープを指定することができます。

分野を分けたり、地域を分けたりなど様々な使い方をすることができます。

スコープは以下のようにツリー構造によって表現することができます。

例： /tokyo/shinjuku/office


# 2-3 FIWARE-ServicePathを指定したEntityの登録

Orionでは"Fiware-ServicePath"というHTTPヘッダーでテナント名を設定することができます。

`curl localhost:1026/v2/entities -s -S -H 'Fiware-ServicePath: /tokyo/shinjuku/office' -H 'Content-Type: application/json' -X POST -d @fiware-part5/assets/example-ngsi-room1.json`

以下のコマンドでEntity一覧を取得します。  
デフォルトのスコープ(/)では全てのスコープが取得されます。

`curl localhost:1026/v2/entities | jq`


別のスコープを指定したコマンドを実行します。  
スコープが異なる場合はEntityが見えません。

`curl localhost:1026/v2/entities -H 'Fiware-ServicePath: /tokyo/shibuya/office' | jq`

以下のコマンドでFiware-ServicePathを指定して取得できます。

`curl localhost:1026/v2/entities -H 'Fiware-ServicePath: /tokyo/shinjuku/office' | jq`


また、Fiware-ServicePathはFiware-Serviceと併用して使うこともできます。

# 2-4 コンテナの停止・削除
起動したコンテナを停止・削除します。

1. 以下コマンドでコンテナを停止・削除します。

   `docker compose -f fiware-part5/assets/docker-compose.yml down`

2. 完了したら以下のコマンドでコンテナが停止・削除されていることを確認します。

   `docker compose -f fiware-part5/assets/docker-compose.yml ps -a`

   一覧に何も表示されていなければ成功です。

[終了](finish.md)

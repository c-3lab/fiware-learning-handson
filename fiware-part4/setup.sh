sleep 1
docker-compose -f fiware-part4/assets/docker-compose.yml up -d
sleep 10
curl localhost:1026/v2/entities -s -S -H 'Content-Type: application/json' -d @fiware-part4/assets/example-ngsi-room1.json

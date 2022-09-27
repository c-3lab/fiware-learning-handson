docker compose -f fiware-part3/assets/docker-compose.yml up -d --build
sleep 5
curl localhost:1026/v2/entities -s -S -H 'Content-Type: application/json' -X POST -d @fiware-part3/assets/example-ngsi-room1.json

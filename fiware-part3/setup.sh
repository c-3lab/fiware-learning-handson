pip install Flask==2.0.2
pip install pyOpenSSL==19.0.0
pip install paho-mqtt==1.6.1
wget -P fiware-part3/assets https://raw.githubusercontent.com/telefonicaid/fiware-orion/master/scripts/accumulator-server.py
chmod a+x fiware-part3/assets/accumulator-server.py
wget -P fiware-part3/assets https://github.com/telefonicaid/fiware-orion/raw/master/docker/docker-compose.yml
docker-compose -f fiware-part3/assets/docker-compose.yml up -d
#rm docker-compose.yml
sleep 5
curl localhost:1026/v2/entities -s -S -H 'Content-Type: application/json' -d @fiware-part3/assets/example-ngsi-room1.json

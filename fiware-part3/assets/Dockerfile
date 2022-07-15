FROM python:3

ENV APP_PATH=/var/www/accumulator

WORKDIR $APP_PATH

RUN pip install Flask==2.0.2
RUN pip install pyOpenSSL==19.0.0
RUN pip install paho-mqtt==1.6.1

RUN wget -P $APP_PATH https://raw.githubusercontent.com/telefonicaid/fiware-orion/master/scripts/accumulator-server.py
RUN chmod a+x $APP_PATH/accumulator-server.py
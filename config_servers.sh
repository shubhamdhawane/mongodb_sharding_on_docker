docker run --log-opt mode=non-blocking \
--network mynet \
--log-driver json-file \
--log-opt max-size=10m \
--log-opt max-file=10 \
-v /mongodb/configserver/data/db41:/data/db -d --expose=27017 --name=configserver41 mongo --configsvr --replSet configserver --dbpath /data/db --port 27017
docker run --log-opt mode=non-blocking \
--network mynet \
--log-driver json-file \
--log-opt max-size=10m \
--log-opt max-file=10 \
-v /mongodb/configserver/data/db42:/data/db -d --expose=27017 --name=configserver42 mongo --configsvr --replSet configserver --dbpath /data/db --port 27017
docker run --log-opt mode=non-blocking \
--network mynet \
--log-driver json-file \
--log-opt max-size=10m \
--log-opt max-file=10 \
-v /mongodb/configserver/data/db43:/data/db -d --expose=27017 --name=configserver43 mongo --configsvr --replSet configserver --dbpath /data/db --port 27017

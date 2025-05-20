docker run --log-opt mode=non-blocking \
--network mynet \
--log-driver json-file \
--log-opt max-size=10m \
--log-opt max-file=10 \
-p 27051:27017 --expose=27017 -d --name=mongos51 mongo mongos --port 27017 --configdb configserver/configserver41:27017,configserver42:27017,configserver43:27017 --bind_ip_all
docker run --log-opt mode=non-blocking \
--network mynet \
--log-driver json-file \
--log-opt max-size=10m \
--log-opt max-file=10 \
-p 27052:27017 --expose=27017 -d --name=mongos52 mongo mongos --port 27017 --configdb configserver/configserver41:27017,configserver42:27017,configserver43:27017 --bind_ip_all

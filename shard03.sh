docker run --log-opt mode=non-blocking \
--network mynet \
--log-driver json-file \
--log-opt max-size=10m \
--log-opt max-file=10 \
-v /mongodb/data/db31:/data/db -p 27031:27017 --expose=27017 -d --name=mongodb31 mongo --shardsvr --replSet shard03 --dbpath /data/db --port 27017
docker run --log-opt mode=non-blocking \
--network mynet \
--log-driver json-file \
--log-opt max-size=10m \
--log-opt max-file=10 \
-v /mongodb/data/db32:/data/db -p 27032:27017 --expose=27017 -d --name=mongodb32 mongo --shardsvr --replSet shard03 --dbpath /data/db --port 27017
docker run --log-opt mode=non-blocking \
--network mynet \
--log-driver json-file \
--log-opt max-size=10m \
--log-opt max-file=10 \
-v /mongodb/data/db33:/data/db  -p 27033:27017  --expose=27017 -d --name=mongodb33 mongo --shardsvr --replSet shard03 --dbpath /data/db --port 27017

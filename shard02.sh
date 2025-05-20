docker run --log-opt mode=non-blocking \
--network mynet \
--log-driver json-file \
--log-opt max-size=10m \
--log-opt max-file=10 \
-v /mongodb/data/db21:/data/db -p 27021:27017 --expose=27017 -d --name=mongodb21 mongo --shardsvr --replSet shard02 --dbpath /data/db --port 27017
docker run --log-opt mode=non-blocking \
--network mynet \
--log-driver json-file \
--log-opt max-size=10m \
--log-opt max-file=10 \
-v /mongodb/data/db22:/data/db -p 27022:27017 --expose=27017 -d --name=mongodb22 mongo --shardsvr --replSet shard02 --dbpath /data/db --port 27017
docker run --log-opt mode=non-blocking \
--network mynet \
--log-driver json-file \
--log-opt max-size=10m \
--log-opt max-file=10 \
-v /mongodb/data/db23:/data/db  -p 27023:27017  --expose=27017 -d --name=mongodb23 mongo --shardsvr --replSet shard02 --dbpath /data/db --port 27017

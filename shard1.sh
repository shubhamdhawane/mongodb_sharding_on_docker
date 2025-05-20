docker run --log-opt mode=non-blocking \
--network mynet \
--log-driver json-file \
--log-opt max-size=10m \
--log-opt max-file=10 \
-v /mongodb/data/db11:/data/db -p 27011:27017 --expose=27017 -d --name=mongodb11 mongo --shardsvr --replSet shard01 --dbpath /data/db --port 27017
docker run --log-opt mode=non-blocking \
--network mynet \
--log-driver json-file \
--log-opt max-size=10m \
--log-opt max-file=10 \
-v /mongodb/data/db12:/data/db  -p 27012:27017  --expose=27017 -d --name=mongodb12 mongo --shardsvr --replSet shard01 --dbpath /data/db --port 27017
docker run --log-opt mode=non-blocking \
--network mynet \
--log-driver json-file \
--log-opt max-size=10m \
--log-opt max-file=10 \
-v /mongodb/data/db13:/data/db  -p 27013:27017  --expose=27017 -d --name=mongodb13 mongo --shardsvr --replSet shard01 --dbpath /data/db --port 27017

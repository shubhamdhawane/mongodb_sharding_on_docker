#!/bin/bash

# Step 1: Create Docker network
docker network create mynet

# Step 2: Start Shard01 replica set
for i in 11 12 13; do
  docker run --log-opt mode=non-blocking \
    --network mynet \
    --log-driver json-file \
    --log-opt max-size=10m \
    --log-opt max-file=10 \
    -v /mongodb/data/db$i:/data/db \
    -p 270$i:27017 --expose=27017 \
    -d --name=mongodb$i mongo \
    --shardsvr --replSet shard01 --dbpath /data/db --port 27017
  sleep 1
done

# Step 3: Start Shard02 replica set
for i in 21 22 23; do
  docker run --log-opt mode=non-blocking \
    --network mynet \
    --log-driver json-file \
    --log-opt max-size=10m \
    --log-opt max-file=10 \
    -v /mongodb/data/db$i:/data/db \
    -p 270$i:27017 --expose=27017 \
    -d --name=mongodb$i mongo \
    --shardsvr --replSet shard02 --dbpath /data/db --port 27017
  sleep 1
done

# Step 4: Start Shard03 replica set
for i in 31 32 33; do
  docker run --log-opt mode=non-blocking \
    --network mynet \
    --log-driver json-file \
    --log-opt max-size=10m \
    --log-opt max-file=10 \
    -v /mongodb/data/db$i:/data/db \
    -p 270$i:27017 --expose=27017 \
    -d --name=mongodb$i mongo \
    --shardsvr --replSet shard03 --dbpath /data/db --port 27017
  sleep 1
done

# Step 5: Start Config Server replica set
for i in 41 42 43; do
  docker run --log-opt mode=non-blocking \
    --network mynet \
    --log-driver json-file \
    --log-opt max-size=10m \
    --log-opt max-file=10 \
    -v /mongodb/configserver/data/db$i:/data/db \
    --expose=27017 -d --name=configserver$i mongo \
    --configsvr --replSet configserver --dbpath /data/db --port 27017
  sleep 1
done

# Step 6: Initiate Config Server Replica Set
docker exec -it configserver41 mongosh --eval '
rs.initiate({
  _id: "configserver",
  configsvr: true,
  members: [
    { _id: 0, host: "configserver41:27017" },
    { _id: 1, host: "configserver42:27017" },
    { _id: 2, host: "configserver43:27017" }
  ]
})'
sleep 10

# Step 7: Start Mongos Routers
for i in 51 52; do
  docker run --log-opt mode=non-blocking \
    --network mynet \
    --log-driver json-file \
    --log-opt max-size=10m \
    --log-opt max-file=10 \
    -p 270$i:27017 --expose=27017 \
    -d --name=mongos$i mongo mongos \
    --port 27017 \
    --configdb configserver/configserver41:27017,configserver42:27017,configserver43:27017 \
    --bind_ip_all
  sleep 1
done

# Step 8: Initiate Shard Replica Sets
docker exec -it mongodb11 mongosh --eval '
rs.initiate({
  _id: "shard01",
  members: [
    { _id: 0, host: "mongodb11:27017" },
    { _id: 1, host: "mongodb12:27017" },
    { _id: 2, host: "mongodb13:27017" }
  ]
})'
sleep 10

docker exec -it mongodb21 mongosh --eval '
rs.initiate({
  _id: "shard02",
  members: [
    { _id: 0, host: "mongodb21:27017" },
    { _id: 1, host: "mongodb22:27017" },
    { _id: 2, host: "mongodb23:27017" }
  ]
})'
sleep 10

docker exec -it mongodb31 mongosh --eval '
rs.initiate({
  _id: "shard03",
  members: [
    { _id: 0, host: "mongodb31:27017" },
    { _id: 1, host: "mongodb32:27017" },
    { _id: 2, host: "mongodb33:27017" }
  ]
})'
sleep 10

# Step 9: Add Shards to Mongos
docker exec -it mongos51 mongosh --eval '
sh.addShard("shard01/mongodb11:27017,mongodb12:27017,mongodb13:27017")
sh.addShard("shard02/mongodb21:27017,mongodb22:27017,mongodb23:27017")
sh.addShard("shard03/mongodb31:27017,mongodb32:27017,mongodb33:27017")
'

# Step 10: Check sharding status
docker exec -it mongos51 mongosh --eval 'sh.status()'

echo "✅ MongoDB sharded cluster setup is complete."

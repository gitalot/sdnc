#!/bin/bash

cpuset_first=0

function get_ip {
    eval ${1}_ip=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1`
}

cpuset=$cpuset_first

echo "Starting redis container... "
docker run --name redis -d torusware/speedus-redis
if [ "$?" != "0" ]; then
    echo "fail"; exit 1;
fi
echo "done"
get_ip redis

echo "Starting graphite container... "
docker run -d --name graphite --restart=always vneio/graphite
if [ "$?" != "0" ]; then
    echo "fail"; exit 1;
fi
echo "done"
get_ip graphite

echo "Starting nerd application container... "
docker run -d --name=nerd --link redis:redis --link graphite:graphite -p 9090:9090 vneio/nerd java -jar vne-io.jar
if [ "$?" != "0" ]; then
    echo "fail"; exit 1;
fi
echo "done"
get_ip nerd

echo "Starting ofc_controller... "
docker run -dt --privileged --name=sdnc -p 6633:6653 --link redis:redis vneio/sdnc /ofc_start.sh --redis-server=redis:6379 -m 100M --cpuset $cpuset
#docker run -dt --privileged --name=sdnc -p 6633:6653 vneio/sdnc /ofc_server --redis-server=${redis_ip}:6379 --cpuset $cpuset
if [ "$?" != "0" ]; then
    echo "fail"; exit 1;
fi
echo "done"
cpuset=$((cpuset + 1))
get_ip sdnc

echo "Starting grafana... "
docker run -dt --name=grafana --link graphite:graphite  -p 3000:3000 vneio/grafana
if [ "$?" != "0" ]; then
    echo "fail"; exit 1;
fi
echo "done"
echo "Adding Grafana Dashboards ..... "
sleep 60
get_ip grafana
curl http://admin:admin@{$grafana_ip}:3000/api/datasources -X POST -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"name":"mydata","type":"graphite","url":"http://graphite","access":"proxy","isDefault":true,"database":"asd"}'
curl http://admin:admin@{$grafana_ip}:3000/api/dashboards/db -X POST -H 'Content-Type: application/json;charset=UTF-8' --data-binary @./docker/templates/FlowStats.json
echo "done"

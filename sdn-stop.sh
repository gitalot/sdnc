#!/bin/bash

echo "Stopping grafana container... "
docker stop grafana 2>/dev/null
docker rm grafana 2>/dev/null
echo "done"

echo "Stopping ofc_controller container... "
docker stop sdnc 2>/dev/null
docker rm sdnc 2>/dev/null
echo "done"

echo "Stopping nerd container... "
docker stop nerd 2>/dev/null
docker rm nerd 2>/dev/null
echo "done"

echo "Stopping redis container... "
docker stop redis 2>/dev/null
docker rm redis 2>/dev/null
echo "done"

echo "Stopping graphite container... "
docker stop graphite 2>/dev/null
docker rm graphite 2>/dev/null
echo "done"

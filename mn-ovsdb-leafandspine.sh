#!/bin/bash
docker run -it --privileged gilyav/mininet /bin/bash -c "service openvswitch-switch start;python /sflow-rt/extras/leafandspine.py --spine=3 --leaf=4 --fanout=5"

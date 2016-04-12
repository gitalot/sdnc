#!/bin/bash
docker run -it --privileged gilyav/mininet /bin/bash -c "service openvswitch-switch start;mn --controller=none --switch=user -i 10.0.2.0 --mac --topo single,10"

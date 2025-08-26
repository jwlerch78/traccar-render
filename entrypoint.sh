#!/bin/sh
set -e

# Ensure TRACCAR_PORT is set
export TRACCAR_PORT=${PORT}

# Start Traccar with host 0.0.0.0
exec /opt/traccar/jre/bin/java -Dtraccar.host=0.0.0.0 -jar /opt/traccar/tracker-server.jar conf/traccar.xml

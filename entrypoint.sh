#!/bin/sh
set -e

# Start Traccar using bundled Java
exec /opt/traccar/jre/bin/java -jar /opt/traccar/tracker-server.jar conf/traccar.xml

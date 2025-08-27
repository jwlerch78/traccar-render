#!/bin/sh
set -e

# Replace default web port with Render-assigned port
sed -i "s/<web.port>8082<\/web.port>/<web.port>${PORT}<\/web.port>/" /opt/traccar/conf/traccar.xml

# Force binding to all interfaces
exec /opt/traccar/jre/bin/java -Dtraccar.host=0.0.0.0 -jar /opt/traccar/tracker-server.jar conf/traccar.xml

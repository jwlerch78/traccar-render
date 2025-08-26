#!/bin/sh
set -e

# Replace the default port with Render's assigned port
sed -i "s/<port>8082<\/port>/<port>${PORT}<\/port>/" /opt/traccar/conf/traccar.xml

# Start Traccar
exec /opt/traccar/jre/bin/java -jar /opt/traccar/tracker-server.jar conf/traccar.xml

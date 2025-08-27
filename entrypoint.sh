#!/bin/sh
set -e

echo "==== ENTRYPOINT START ===="
echo "Render assigned PORT = $PORT"

TRACCAR_CONF=/opt/traccar/conf/traccar.xml

# Backup XML
cp $TRACCAR_CONF $TRACCAR_CONF.bak

# Update web port in XML as a fallback
sed -i "s#<web.port>[0-9]\+</web.port>#<web.port>${PORT}</web.port>#" $TRACCAR_CONF

echo "Launching Traccar on 0.0.0.0:$PORT..."

# Start Traccar with forced web port and host binding
/opt/traccar/jre/bin/java -Dtraccar.host=0.0.0.0 -Dtraccar.web.port=$PORT -jar /opt/traccar/tracker-server.jar $TRACCAR_CONF &

sleep 5

echo "=== LISTENING PORTS ==="
netstat -tulpn || echo "netstat command not available"

wait

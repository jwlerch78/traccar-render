#!/bin/sh
set -e

echo "==== ENTRYPOINT START ===="
echo "Render assigned PORT = $PORT"

# Validate that PORT is set
if [ -z "$PORT" ]; then
  echo "ERROR: PORT environment variable is not set!"
  exit 1
fi

TRACCAR_CONF=/opt/traccar/conf/traccar.xml

# Backup original XML just in case
cp $TRACCAR_CONF $TRACCAR_CONF.bak

# Safely replace the web port in XML
# Match <web.port>anynumber</web.port>
sed -i "s#<web.port>[0-9]\+</web.port>#<web.port>${PORT}</web.port>#" $TRACCAR_CONF

echo "Updated $TRACCAR_CONF with PORT=$PORT"
echo "Launching Traccar..."

# Start Traccar with host 0.0.0.0 so Render can detect it
/opt/traccar/jre/bin/java -Dtraccar.host=0.0.0.0 -jar /opt/traccar/tracker-server.jar $TRACCAR_CONF &

# Give server a few seconds to bind
sleep 5

# Debug: show listening ports
echo "=== LISTENING PORTS ==="
netstat -tulpn || echo "netstat command not available"

# Keep container running
wait

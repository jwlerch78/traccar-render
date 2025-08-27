#!/bin/sh
set -e

echo "==== ENTRYPOINT START ===="

# Use Render's assigned PORT, default to 8082
PORT=${PORT:-8082}
echo "Render assigned PORT = $PORT"

TRACCAR_CONF=/opt/traccar/conf/traccar.xml

# Set environment variable so Traccar binds correctly
export TRACCAR_PORT=$PORT

# Patch traccar.xml: insert or replace <web.port>
if [ -f "$TRACCAR_CONF" ]; then
    if grep -q "web.port" "$TRACCAR_CONF"; then
        sed -i "s|<entry key='web.port'>.*</entry>|<entry key='web.port'>${PORT}</entry>|" "$TRACCAR_CONF"
    else
        sed -i "/<\/properties>/i \    <entry key='web.port'>${PORT}</entry>" "$TRACCAR_CONF"
    fi
    echo "Updated $TRACCAR_CONF with web.port=$PORT"
else
    echo "⚠️ No traccar.xml found at $TRACCAR_CONF!"
fi

# Debug info: web.port and last 20 lines of XML
echo "==== DEBUG: web.port entry in traccar.xml ===="
grep "web.port" "$TRACCAR_CONF" || echo "web.port not found!"
echo "==== END DEBUG ===="

echo "==== DEBUG: Last 20 lines of traccar.xml ===="
tail -n 20 "$TRACCAR_CONF"
echo "==== END DEBUG ===="

# Debug: environment variables
echo "==== DEBUG: Environment variables ===="
env | grep PORT
env | grep TRACCAR_PORT
echo "==== END DEBUG ===="

# Wait a few seconds and check listening TCP ports
sleep 5
echo "==== DEBUG: Listening TCP ports ===="
netstat -tuln || ss -tuln || echo "no netstat/ss available"
echo "==== END DEBUG ===="

# Launch Traccar in foreground using bundled JRE
echo "Launching Traccar on 0.0.0.0:$PORT..."
exec /opt/traccar/jre/bin/java -jar /opt/traccar/tracker-server.jar "$TRACCAR_CONF"

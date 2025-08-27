#!/bin/sh
set -e
echo "==== ENTRYPOINT START ===="

# Use Render's assigned PORT, default to 8082
PORT=${PORT:-8082}
echo "Render assigned PORT = $PORT"

TRACCAR_CONF=/opt/traccar/conf/traccar.xml

# Patch traccar.xml
if [ -f "$TRACCAR_CONF" ]; then
    if grep -q "web.port" "$TRACCAR_CONF"; then
        sed -i "s|<entry key='web.port'>.*</entry>|<entry key='web.port'>${PORT}</entry>|" "$TRACCAR_CONF"
    else
        sed -i "/<\/properties>/i \    <entry key='web.port'>${PORT}</entry>" "$TRACCAR_CONF"
    fi
    echo "Updated $TRACCAR_CONF with PORT=$PORT"
else
    echo "⚠️ No traccar.xml found at $TRACCAR_CONF!"
fi

echo "==== DEBUG: web.port entry in traccar.xml ===="
grep "web.port" "$TRACCAR_CONF" || echo "web.port not found!"

# Launch Traccar in FOREGROUND (remove &)
echo "Launching Traccar on 0.0.0.0:$PORT..."
exec /opt/traccar/jre/bin/java -jar /opt/traccar/tracker-server.jar conf/traccar.xml

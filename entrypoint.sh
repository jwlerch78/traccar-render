#!/bin/sh
set -e
echo "==== ENTRYPOINT START ===="

PORT=${PORT:-8082}
echo "Render assigned PORT = $PORT"

TRACCAR_CONF=/opt/traccar/conf/traccar.xml

# Patch traccar.xml with BOTH port AND host
if [ -f "$TRACCAR_CONF" ]; then
    # Add/update web.port
    if grep -q "web.port" "$TRACCAR_CONF"; then
        sed -i "s|<entry key='web.port'>.*</entry>|<entry key='web.port'>${PORT}</entry>|" "$TRACCAR_CONF"
    else
        sed -i "/<\/properties>/i \    <entry key='web.port'>${PORT}</entry>" "$TRACCAR_CONF"
    fi
    
    # Add/update web.address to bind to all interfaces
    if grep -q "web.address" "$TRACCAR_CONF"; then
        sed -i "s|<entry key='web.address'>.*</entry>|<entry key='web.address'>0.0.0.0</entry>|" "$TRACCAR_CONF"
    else
        sed -i "/<\/properties>/i \    <entry key='web.address'>0.0.0.0</entry>" "$TRACCAR_CONF"
    fi
    
    echo "Updated $TRACCAR_CONF with PORT=$PORT and HOST=0.0.0.0"
else
    echo "⚠️ No traccar.xml found at $TRACCAR_CONF!"
fi

echo "==== DEBUG: web config in traccar.xml ===="
grep -E "web\.(port|address)" "$TRACCAR_CONF" || echo "web config not found!"

echo "Launching Traccar on 0.0.0.0:$PORT..."
exec /opt/traccar/jre/bin/java -jar /opt/traccar/tracker-server.jar conf/traccar.xml

#!/bin/sh
set -e

echo "==== ENTRYPOINT START ===="

# Use Render's assigned PORT, default to 8082 if not set
PORT=${PORT:-8082}
echo "Render assigned PORT = $PORT"

# Path to Traccar config
TRACCAR_CONF=/opt/traccar/conf/traccar.xml

# Patch traccar.xml to bind the web server to $PORT
if [ -f "$TRACCAR_CONF" ]; then
  sed -i "s|<entry key=\"web.port\">.*</entry>|<entry key=\"web.port\">${PORT}</entry>|" "$TRACCAR_CONF"
  echo "Updated $TRACCAR_CONF with PORT=$PORT"

  # Verify the patch
  echo "==== DEBUG: web.port entry in traccar.xml ===="
  grep "web.port" "$TRACCAR_CONF" || echo "web.port not found!"
  echo "==== END DEBUG ===="
else
  echo "⚠️ No traccar.xml found at $TRACCAR_CONF!"
fi

echo "Launching Traccar on 0.0.0.0:$PORT..."
exec /opt/traccar/jre/bin/java -jar /opt/traccar/tracker-server.jar conf/traccar.xml

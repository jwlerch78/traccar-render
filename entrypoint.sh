#!/bin/sh
set -e

echo "==== ENTRYPOINT START ===="

# Debug: list all files under /opt/traccar
echo "==== DEBUG: /opt/traccar contents ===="
ls -R /opt/traccar
echo "==== END DEBUG ===="

# Use Render's assigned PORT, default to 8082 if not set
PORT=${PORT:-8082}
echo "Render assigned PORT = $PORT"

# Patch traccar.xml to bind the web server to $PORT
TRACCAR_CONF=/opt/traccar/conf/traccar.xml
if [ -f "$TRACCAR_CONF" ]; then
  sed -i "s|<entry key=\"web.port\">.*</entry>|<entry key=\"web.port\">${PORT}</entry>|" "$TRACCAR_CONF"
  echo "Updated $TRACCAR_CONF with PORT=$PORT"

  echo "==== DEBUG: First 20 lines of traccar.xml ===="
  head -n 20 "$TRACCAR_CONF"
  echo "==== END DEBUG ===="
else
  echo "⚠️ No traccar.xml found at $TRACCAR_CONF!"
fi

echo "Launching Traccar on 0.0.0.0:$PORT..."
exec java -jar /opt/traccar/tracker-server.jar conf/traccar.xml

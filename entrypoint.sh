#!/bin/sh
set -e

echo "==== ENTRYPOINT START ===="

# Use Render's assigned PORT, default to 8082 if not set
PORT=${PORT:-8082}
echo "Render assigned PORT = $PORT"

# Patch traccar.xml to bind the web server to $PORT
if [ -f /opt/traccar/conf/traccar.xml ]; then
  sed -i "s|<entry key=\"web.port\">.*</entry>|<entry key=\"web.port\">${PORT}</entry>|" /opt/traccar/conf/traccar.xml
  echo "Updated /opt/traccar/conf/traccar.xml with PORT=$PORT"
else
  echo "⚠️ No traccar.xml found!"
fi

echo "Launching Traccar on 0.0.0.0:$PORT..."
exec sh /opt/traccar/bin/traccar run

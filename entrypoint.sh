#!/bin/sh
echo "==== ENTRYPOINT START ===="

PORT=${PORT:-10000}
echo "Render assigned PORT = $PORT"

# Update XML so web.port matches Render’s PORT
sed -i "s|<entry key='web.port'>.*</entry>|<entry key='web.port'>$PORT</entry>|" /opt/traccar/conf/traccar.xml

echo "Launching Traccar in foreground on 0.0.0.0:$PORT..."
exec /opt/traccar/bin/traccar run

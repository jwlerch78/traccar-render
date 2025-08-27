#!/bin/sh
set -e

echo "==== ENTRYPOINT DEBUG START ===="
echo "Render assigned PORT = ${PORT:-not set}"

TRACCAR_CONF=/opt/traccar/conf/traccar.xml

# Debug: show web.port entry
echo "==== DEBUG: web.port in traccar.xml ===="
grep "web.port" "$TRACCAR_CONF" || echo "web.port not found!"
echo "==== END DEBUG ===="

# Debug: show last 20 lines of XML
echo "==== DEBUG: Last 20 lines of traccar.xml ===="
tail -n 20 "$TRACCAR_CONF"
echo "==== END DEBUG ===="

# Debug: listening TCP ports
sleep 5
echo "==== DEBUG: Listening TCP ports ===="
netstat -tuln || ss -tuln || echo "no netstat/ss available"
echo "==== END DEBUG ===="

# Now run the official Traccar entrypoint
echo "Launching Traccar..."
exec /entrypoint.sh.orig

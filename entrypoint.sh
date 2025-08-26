#!/bin/sh
set -e

# Replace hardcoded 8082 with Render’s assigned port
sed -i "s/<port>8082<\/port>/<port>${PORT}<\/port>/" /opt/traccar/conf/traccar.xml

# Start Traccar
exec /opt/traccar/bin/traccar run

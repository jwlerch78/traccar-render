#!/bin/sh
set -e

# Update port inside config
sed -i "s/<port>8082<\/port>/<port>${PORT}<\/port>/" /opt/traccar/conf/traccar.xml

# Run the original start script (the image defaults to this)
exec ./traccar.run

#!/bin/sh
set -e

echo "Listing /opt/traccar"
ls -R /opt/traccar

# Sleep to keep container alive for inspection
sleep 600

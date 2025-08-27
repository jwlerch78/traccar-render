FROM traccar/traccar:latest

# Copy your entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Force Traccar’s web.port to Render’s expected 10000
RUN sed -i "s|<entry key='web.port'>.*</entry>|<entry key='web.port'>10000</entry>|" /opt/traccar/conf/traccar.xml

ENTRYPOINT ["/entrypoint.sh"]

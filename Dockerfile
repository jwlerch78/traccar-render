FROM traccar/traccar:latest

# Create startup script that uses PORT environment variable
RUN echo '#!/bin/sh' > /start.sh && \
    echo 'java -Dfile.encoding=UTF-8 -Dweb.port=${PORT:-8082} -jar /opt/traccar/traccar.jar /opt/traccar/conf/traccar.xml' >> /start.sh && \
    chmod +x /start.sh

CMD ["/start.sh"]

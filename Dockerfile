FROM traccar/traccar:latest

# Create a custom config that uses PORT env var
COPY <<EOF /opt/traccar/conf/traccar.xml
<?xml version='1.0' encoding='UTF-8'?>
<!DOCTYPE properties SYSTEM 'http://java.sun.com/dtd/properties.dtd'>
<properties>
    <entry key='web.port'>\${PORT}</entry>
    <entry key='database.driver'>org.h2.Driver</entry>
    <entry key='database.url'>jdbc:h2:./data/database</entry>
    <entry key='database.user'>sa</entry>
    <entry key='database.password'></entry>
</properties>
EOF

# Use environment variable substitution
CMD java -Dconfig.file=/opt/traccar/conf/traccar.xml -jar /opt/traccar/traccar.jar

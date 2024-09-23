FROM tomcat:latest
COPY target/your-app.war /usr/local/tomcat/webapps/

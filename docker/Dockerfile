
# Tomcat 10.1 image with Apache's sample web application
FROM tomcat:10.1-jdk21
LABEL maintainer="Ammar Zeyad"

# Downloaded at build time, so no WAR file is stored in the repository
ADD https://tomcat.apache.org/tomcat-10.1-doc/appdev/sample/sample.war /usr/local/tomcat/webapps/sample.war

EXPOSE 8080
CMD ["catalina.sh", "run"]

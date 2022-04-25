RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz
  
FROM tomcat

COPY target/hello-world-war-1.0.0.war /usr/local/tomcat/webapps/ROOT.war
COPY target/hello-world-war-1.0.0/ /usr/local/tomcat/webapps/ROOT

EXPOSE 8080


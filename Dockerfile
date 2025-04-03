# Base image
FROM ubuntu:latest

# Install dependencies
RUN apt update && apt install -y openjdk-17-jdk wget curl unzip mysql-server

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Install Apache Tomcat
WORKDIR /opt
RUN wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.80/bin/apache-tomcat-9.0.80.tar.gz \
    && tar -xvf apache-tomcat-9.0.80.tar.gz \
    && rm apache-tomcat-9.0.80.tar.gz

ENV CATALINA_HOME=/opt/apache-tomcat-9.0.80
ENV PATH=$CATALINA_HOME/bin:$PATH

# Install Spring Boot CLI
RUN curl -s https://get.sdkman.io | bash && \
    source "$HOME/.sdkman/bin/sdkman-init.sh" && \
    sdk install springboot

# Expose ports
EXPOSE 8080 3306

# Set working directory
WORKDIR /opt/apache-tomcat-9.0.80

# Start Tomcat
CMD ["bin/catalina.sh", "run"]

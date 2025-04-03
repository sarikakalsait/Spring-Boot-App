# Use Ubuntu as the base image
FROM ubuntu:latest

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Update packages and install dependencies
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    wget \
    unzip \
    mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Install Apache Tomcat
WORKDIR /usr/local
RUN apt-get update && apt-get install -y wget \
    && wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.82/bin/apache-tomcat-9.0.82.tar.gz \
    && tar xvf apache-tomcat-9.0.82.tar.gz \
    && mv apache-tomcat-9.0.82 /usr/local/tomcat \
    && rm apache-tomcat-9.0.82.tar.gz

# Set environment variables for Tomcat
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH="$CATALINA_HOME/bin:$PATH"

# Install and configure Spring Boot, Spring Cloud (via Maven)
RUN apt-get update && apt-get install -y maven

# Set working directory
WORKDIR /app

# Copy application files
COPY . .

# Expose necessary ports
EXPOSE 8080 3306

# Start Tomcat
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]

FROM ubuntu:16.04

MAINTAINER Houzard Jean-François <jhouzard@gmail.com>

ENV MAVEN_VERSION=3.2.5
ENV JAVA_VERSION_MAJOR=8
ENV JAVA_VERSION_MINOR=101
ENV JAVA_VERSION_BUILD=06

# update dpkg repositories
RUN apt-get update \
 && apt-get install -y wget \
 && apt-get clean

# Install maven
RUN wget --no-verbose -O /tmp/apache-maven-${MAVEN_VERSION}.tar.gz http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
 && tar xzf /tmp/apache-maven-${MAVEN_VERSION}.tar.gz -C /opt/ \
 && ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven \
 && rm -f /tmp/apache-maven-${MAVEN_VERSION}.tar.gz

# Update settings.xml
# Externalise repository?

ENV MAVEN_HOME /opt/maven

# Install java
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.bin" \
 && chmod +x jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.bin \
 && ./jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.bin \
 && rm jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.bin \
 && mv jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/oracle-jdk-1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} \
 && ln -s /opt/oracle-jdk-1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/java

ENV JAVA_HOME /opt/java
ENV PATH $JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH
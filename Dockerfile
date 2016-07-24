FROM ubuntu:16.04

MAINTAINER Houzard Jean-François <jhouzard@gmail.com>

ENV MAVEN_VERSION 3.2.5
ENV JAVA_VERSION_MAJOR=6
ENV JAVA_VERSION_MINOR=45
ENV JAVA_VERSION_BUILD=06

# update dpkg repositories
RUN apt-get update

# install wget
RUN apt-get install -y wget

# remove download archive files
RUN apt-get clean

# get maven ${MAVEN_VERSION}
RUN wget --no-verbose -O /tmp/apache-maven-${MAVEN_VERSION}.tar.gz http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz

# install maven
RUN tar xzf /tmp/apache-maven-${MAVEN_VERSION}.tar.gz -C /opt/
RUN ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven
RUN ln -s /opt/maven/bin/mvn /usr/local/bin
RUN rm -f /tmp/apache-maven-${MAVEN_VERSION}.tar.gz
ENV MAVEN_HOME /opt/maven

# set shell variables for java installation
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.bin"

RUN chmod +x jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.bin
RUN ./jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.bin
RUN rm jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.bin

RUN mv jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/oracle-jdk-1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}
RUN ln -s /opt/oracle-jdk-1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/java
ENV JAVA_HOME /opt/java

ENV PATH $JAVA_HOME/bin:$PATH


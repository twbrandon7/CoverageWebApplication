FROM tomcat:9.0.68-jdk8
LABEL maintainer="lxchen@cs.nctu.edu.tw"

USER root

RUN mkdir -p /root/CoverageWebApplication

COPY . /root/CoverageWebApplication

RUN cd /root && \
    wget --no-check-certificate https://dlcdn.apache.org//ant/binaries/apache-ant-1.9.16-bin.tar.gz && \
    tar zxvf apache-ant-1.9.16-bin.tar.gz

RUN apt-get update &&\
    apt-get install -y expect

ENV WEBAPPS_DIR=/usr/local/tomcat/webapps/ROOT

RUN mkdir -p $WEBAPPS_DIR && \
    cd /root/CoverageWebApplication && \
    cp -r WebContent webcontent &&\
    /root/apache-ant-1.9.16/bin/ant build

RUN expect /root/CoverageWebApplication/assets/expect_deploy &&\
    cp /root/CoverageWebApplication/assets/index.html $WEBAPPS_DIR

# Clean up
RUN apt-get clean autoclean &&\
    apt-get autoremove --yes &&\
    rm -rf /var/lib/{apt,dpkg,cache,log}/

EXPOSE 8080
CMD ["catalina.sh", "run"]
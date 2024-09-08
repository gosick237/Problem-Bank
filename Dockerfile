#################### DEV BUILD IMAGE ####################
FROM exoplatform/jdk:openjdk-11-ubuntu-2204 AS dev
MAINTAINER yh "yeonghun_lee@tmax.co.kr"

# Base Install and "APT Install"
RUN apt-get update -y \
    && apt-get install -y git openssh-server

WORKDIR /home/yh

#################### DEV BUILD IMAGE ####################


#################### Ops IMAGE ####################
FROM openjdk:11-jdk-slim AS ops
MAINTAINER yh "yeonghun_lee@tmax.co.kr"

# Base Install and "APT Install"
RUN apt-get update -y

WORKDIR /home/pb

ENV SCRIPT_HOME /home/pb/script

RUN mkdir -p ${SCRIPT_HOME}

COPY config/start.sh ${SCRIPT_HOME}/start.sh
COPY config/env.sh ${SCRIPT_HOME}/env.sh
COPY config/application.properties ./application.properties

RUN chmod -R 755 ${SCRIPT_HOME}

ADD /WaplMath/build/libs/*.jar /home/tmax/app.jar

ENTRYPOINT ["./script/start.sh"]
#################### Ops IMAGE ####################
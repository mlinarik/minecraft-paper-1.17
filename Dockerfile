
#Parent Image
FROM openjdk:17-jdk-slim-buster as base

#Builder
FROM base as builder
RUN apt-get update -y && apt-get install wget -y && \
   mkdir /mcdata && mkdir /temp

RUN wget -c https://papermc.io/api/v2/projects/paper/versions/1.17.1/builds/293/downloads/paper-1.17.1-293.jar -O /temp/server.jar && \
   touch /temp/eula.txt && echo "eula=true" > /temp/eula.txt

#Build process 2
FROM openjdk:17-jdk-slim-buster as builder2

RUN yum update -y && \
   yum upgrade -y && \
   yum clear all && \
   mkdir /temp && \
   mkdir /mcdata

COPY --from=builder /temp /temp

WORKDIR /mcdata

EXPOSE 25565

CMD mv /temp/*.* /mcdata && java -Xms4G -jar server.jar nogui

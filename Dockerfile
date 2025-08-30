# The Dockerfile for build localhost source, not git repo
# FROM debian:bookworm AS builder
FROM ubuntu:20.04 as builder
LABEL maintainer=""

ENV VERSION 3.0
WORKDIR /

COPY . /
RUN apt-get update && \
    apt-get -y install wget && \
    /bin/bash -c '/bin/echo -e "1\n\nn\n" | ./status.sh' && \
    cp -rf /web /usr/local/ServerStatus/

# glibc env run
FROM nginx:1.17.8

COPY --from=builder /usr/local/ServerStatus/server /ServerStatus/server/
COPY --from=builder /usr/local/ServerStatus/web /usr/share/nginx/html/

# china time 
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 80 35601
HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD curl --fail http://localhost:80 || bash -c 'kill -s 15 -1 && (sleep 10; kill -s 9 -1)'
CMD nohup sh -c '/etc/init.d/nginx start && /ServerStatus/server/sergate --config=/ServerStatus/server/config.json --web-dir=/usr/share/nginx/html'

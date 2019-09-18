#
# Dockerfile for v2ray
#

FROM alpine:3.8
MAINTAINER William Wang <william@10ln.com>

ARG SS_VER=4.20.0
ARG SS_URL=https://github.com/v2ray/v2ray-core/releases/download/v$SS_VER/v2ray-linux-64.zip

ENV SERVER_PORT 8388
RUN echo "https://mirrors.tuna.tsinghua.edu.cn/alpine/v3.8/main" > /etc/apk/repositories && \
echo "https://mirrors.tuna.tsinghua.edu.cn/alpine/v3.8/community" >> /etc/apk/repositories && \
set -ex && \
    apk add --no-cache --virtual wget unzip \
    bash ca-certificates openssl curl tzdata pngquant \
    autoconf automake build-base libtool nasm c-ares-dev && \
    cd /tmp && \
    wget --no-check-certificate $SS_URL -O temp.zip && \
    unzip temp.zip && \
    cp ./v2ray*/v2ray /usr/bin/v2ray && \
    cp ./v2ray*/v2ctl /usr/bin/v2ctl && \
    cd .. && \
    chmod 755 /usr/bin/v2ray && \
    chmod 755 /usr/bin/v2ctl && \
    rm -rf /tmp/*

USER nobody

EXPOSE $SERVER_PORT/tcp $SERVER_PORT/udp

CMD v2ray -config=$CFG_FILE

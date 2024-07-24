FROM alpine:3.18
RUN apk add --no-cache openrc sudo bash curl
RUN wget -O - thin-edge.io/install.sh | sh -s \
    && apk add --no-cache \
        tedge-apk-plugin \
        c8y-command-plugin

COPY ./images/files/bootstrap.sh /usr/bin/
COPY ./dist/*.apk /tmp/
RUN apk add --allow-untrusted /tmp/tedge-archive-plugin*.apk

ENTRYPOINT ["/sbin/init"]
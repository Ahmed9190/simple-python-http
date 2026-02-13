ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache python3 py3-pip

WORKDIR /data

COPY rootfs/ /

RUN chmod a+x /usr/bin/run.sh

CMD ["/usr/bin/run.sh"]

FROM alpine:latest
MAINTAINER Ignatius Teo <ignatius.teo@gmail.com>

EXPOSE 8118

RUN apk --update --no-cache add privoxy openvpn runit

COPY app /app

RUN find /app -name run | xargs chmod u+x

ENV VPNHOST="hk.windscribe.com" \
    VPNPORT=443 \
    USERNAME="" \
    PASSWORD="" \
    LOCAL_NETWORK=192.168.88.0/24

CMD ["runsvdir", "/app"]

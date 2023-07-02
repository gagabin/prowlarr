FROM docker.io/library/alpine:latest
RUN apk upgrade --no-cache
RUN apk add --no-cache execline icu-libs sqlite-libs
ADD https://prowlarr.servarr.com/v1/update/master/updatefile?os=linuxmusl&runtime=netcore&arch=x64 /tmp/prowlarr.tar.gz
RUN mkdir -p /opt/prowlarr/bin
RUN tar xf /tmp/prowlarr.tar.gz -C /opt/prowlarr/bin --strip-components=1
RUN rm /tmp/prowlarr.tar.gz
RUN rm -r /opt/prowlarr/bin/Prowlarr.Update
RUN echo UpdateMethod=Docker >/opt/prowlarr/package_info
COPY /init /
EXPOSE 9696
ENTRYPOINT ["/init"]

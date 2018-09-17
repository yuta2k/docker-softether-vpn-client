FROM alpine:3.8
LABEL maintainer="Antoine Mary <antoinee.mary@gmail.com>" \
      contributor="Dimitri G. <dev@dmgnx.net>"

### SET ENVIRONNEMENT
ENV LANG="en_US.UTF-8"

### SETUP
COPY assets /assets
RUN set -ex ; \
    addgroup -S softether ; adduser -D -H softether -g 'softether' -G softether -s /bin/sh ; \
    apk add --no-cache --update --virtual .build-deps \
      gcc g++ make musl-dev ncurses-dev openssl-dev readline-dev cmake git ; \
    mv /assets/entrypoint.sh / && chmod +x /entrypoint.sh && \
    # Fetch sources
    git clone https://github.com/SoftEtherVPN/SoftEtherVPN.git ; \
    cd SoftEtherVPN ; \
    git submodule init && git submodule update ; \
    # Compile and Install
    ./configure ; \
    make -C tmp ; make -C tmp install ; make -C tmp clean ; \
    # Cleanning
    apk del .build-deps ; \
    # Reintroduce necessary libraries
    apk add --no-cache --virtual .run-deps \
      libcap libcrypto1.0 libssl1.0 ncurses-libs readline su-exec ; \
    # Removing vpnbridge, vpncmd vpnserver and build files
    cd .. ; rm -rf /usr/local/libexec/softether/vpnserver /usr/local/bin/vpnserver \
      /usr/local/libexec/softether/vpnbridge /usr/local/bin/vpnbridge \
      /assets SoftEtherVPN ;

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/local/bin/vpnclient", "execsvc"]

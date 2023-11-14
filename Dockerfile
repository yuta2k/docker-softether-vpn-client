FROM alpine:3.18 as builder
LABEL maintainer="Antoine Mary <antoinee.mary@gmail.com>" \
      contributor="Dimitri G. <dev@dmgnx.net>"

### SET ENVIRONNEMENT
ENV LANG="en_US.UTF-8"

### SETUP
RUN set -ex ; \
    apk add --no-cache --update --virtual .build-deps \
      gcc g++ make musl-dev ncurses-dev openssl-dev readline-dev cmake git zlib-dev ; \
    # Fetch sources
    git clone https://github.com/SoftEtherVPN/SoftEtherVPN_Stable.git ; \
    cd SoftEtherVPN_Stable ; \
    git submodule init && git submodule update ; \
    # Compile and Install
    ./configure ; \
    make ; make install ; make clean ;


FROM alpine:3.18

# Adjust at runtime
#ENV SE_SERVER
#ENV SE_HUB
#ENV SE_USERNAME
#ENV SE_PASSWORD

# Default values
ENV SE_ACCOUNT_NAME=default
ENV SE_TYPE=standard
ENV SE_NICNAME=vpn

COPY assets/entrypoint.sh /entrypoint.sh
COPY assets/supervisord.conf /etc/
COPY assets/dhclient-enter-hooks /etc/dhclient-enter-hooks

RUN set -ex ; \
    apk --update --no-cache add \
      libcap libcrypto1.1 libssl1.1 ncurses-libs readline supervisor dhclient ; \
    chmod +x /entrypoint.sh \
      /etc/dhclient-enter-hooks

COPY --from=builder /usr/vpnclient /usr/vpnclient
COPY --from=builder /usr/bin/vpnclient /usr/bin/vpnclient
COPY --from=builder /usr/vpncmd /usr/vpncmd
COPY --from=builder /usr/bin/vpncmd /usr/bin/vpncmd

ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord", "-c", "/etc/supervisord.conf"]

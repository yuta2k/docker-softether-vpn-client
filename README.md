# Lightweight Softether VPN Client

TODO: rewrite

## Build

```shell
docker build -t nefarius/docker-softether-vpn-client https://github.com/nefarius/docker-softether-vpn-client.git#master
```

## Run

### Standalone

```shell
docker run --name=docker-softether-vpn-client \
    --restart=always \
    --privileged --cap-add NET_ADMIN \
    -e SE_SERVER=vpn.example.net:443 \
    -e SE_HUB=TheHub \
    -e SE_USERNAME=vpnuser \
    -e SE_PASSWORD=Sup3rS3cr3t \
    -d nefarius/docker-softether-vpn-client:latest
```

### Compose file

```docker-compose
version: "3"

services:
  vpnclient:
    image: nefarius/docker-softether-vpn-client:latest
    container_name: docker-softether-vpn-client
    privileged: true
    cap_add:
      - NET_ADMIN
    environment:
      - SE_SERVER=vpn.example.net:443
      - SE_HUB=TheHub
      - SE_USERNAME=vpnuser
      - SE_PASSWORD=Sup3rS3cr3t
    restart: always

```
FROM ghcr.io/tailscale/tailscale:v1.34.1 as ts
FROM drone/drone-runner-docker:latest as drone

FROM alpine:3.13 as build

RUN mkdir /rootfs
ADD https://repo-default.voidlinux.org/live/current/void-x86_64-ROOTFS-20221001.tar.xz /rootfs
WORKDIR /rootfs
RUN tar xvf *.tar.xz
RUN rm -rf *.tar.xz

FROM scratch

COPY --from=build /rootfs /
COPY --from=ts /usr/local/bin/tailscale /bin/tailscale
COPY --from=ts /usr/local/bin/tailscaled /bin/tailscaled
COPY --from=drone /bin/drone-runner-docker /bin/drone-runner-docker

#RUN xbps-install -u xbps
#RUN xbps-install -Sy socklog socklog-void cronie vsv iptables

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
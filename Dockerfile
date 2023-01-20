FROM ghcr.io/tailscale/tailscale:v1.34.1 as ts
FROM drone/drone:latest

COPY --from=ts /usr/local/bin/tailscale /bin/tailscale
COPY --from=ts /usr/local/bin/tailscaled /bin/tailscaled

# required to run tailscale
RUN apk add iptables

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x ./entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
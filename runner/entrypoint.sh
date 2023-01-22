#!/bin/sh

tailscaled -statedir /data/tailscale -state /data/tailscale/state &> /dev/null &

sleep 10 && tailscale up \
    --ssh --accept-routes --auth-key "$TSKEY" \
    --hostname "$HOSTNAME" && \

/bin/drone-runner-docker
#!/bin/sh

tailscaled -statedir /data/tailscale -state /data/tailscale/state &> /dev/null &

sleep 10 && tailscale up --ssh --accept-routes --auth-key "$TSKEY" --hostname ci && cd /data && tailscale cert "ci.tail9b256.ts.net"

export DRONE_TLS_CERT=/data/ci.tail9b256.ts.net.crt
export DRONE_TLS_KEY=/data/ci.tail9b256.ts.net.key
/bin/drone-server &

wait -n
exit $?
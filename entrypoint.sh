#!/bin/sh
# Render the sing-box config from environment variables, then run sing-box.
# Required: UUID, WS_PATH. Optional: PORT (default 8080).
# No TLS here: the platform terminates HTTPS in front of the container.
set -eu

: "${UUID:?ERROR: UUID env var is required}"
: "${WS_PATH:?ERROR: WS_PATH env var is required}"
PORT="${PORT:-8080}"

sed -e "s|__PORT__|${PORT}|g" \
    -e "s|__UUID__|${UUID}|g" \
    -e "s|__WS_PATH__|${WS_PATH}|g" \
    /config.template.json > /tmp/config.json

exec sing-box run -c /tmp/config.json

# Pinned, auditable sing-box node image (VLESS + WebSocket, no TLS —
# the platform terminates HTTPS). All settings come from environment
# variables at runtime; nothing secret is baked into the image.

# Stage 1: pinned official sing-box image, used only as the binary source.
FROM ghcr.io/sagernet/sing-box:v1.12.10 AS sing-box

# Stage 2: minimal runtime.
FROM alpine:3.20

RUN apk add --no-cache ca-certificates

# Assumption: the official sing-box image ships the binary at
# /usr/local/bin/sing-box (true for recent official images).
COPY --from=sing-box /usr/local/bin/sing-box /usr/local/bin/sing-box
COPY config.template.json /config.template.json
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]

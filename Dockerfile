# Two-stage: grab the Caddy binary from the official image, then drop it into
# a clean Alpine base. We do this so our final image declares ONLY `EXPOSE 8080`
# — the caddy:alpine base also exposes 80/443/2019, and Temps' port detection
# picks the first one it sees from that list (it picked 443) regardless of
# anything we append. A clean base gives Temps exactly one port to find.
FROM caddy:2-alpine AS caddy-src

FROM alpine:3.19

# ca-certificates for TLS, mailcap so Caddy can guess MIME types
RUN apk add --no-cache ca-certificates mailcap \
    && mkdir -p /config/caddy /data/caddy /etc/caddy /usr/share/caddy

COPY --from=caddy-src /usr/bin/caddy /usr/bin/caddy
COPY Caddyfile /etc/caddy/Caddyfile
COPY index.html /usr/share/caddy/index.html

# Non-privileged port: no CAP_NET_BIND_SERVICE required, no clash with
# Temps' no_new_privs runtime.
EXPOSE 8080

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]

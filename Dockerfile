FROM caddy:2-alpine

COPY Caddyfile /etc/caddy/Caddyfile
COPY index.html /usr/share/caddy/index.html

# Caddy picks up $PORT from the Caddyfile; default 80.
EXPOSE 80

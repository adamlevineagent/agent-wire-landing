FROM caddy:2-alpine

# Temps runs containers with no_new_privs, which makes the kernel refuse to
# exec a binary that carries file capabilities. The Caddy Alpine image sets
# cap_net_bind_service on /usr/bin/caddy; we don't need it because we bind
# to a non-privileged port (8080), so strip the caps to let exec succeed.
RUN setcap -r /usr/bin/caddy || true

COPY Caddyfile /etc/caddy/Caddyfile
COPY index.html /usr/share/caddy/index.html

# Caddy reads $PORT from the Caddyfile; default 8080.
EXPOSE 8080

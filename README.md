# agent-wire.com

Landing page for the Wire — the network of understanding pyramids.

Single static file. Served by Caddy. Deployed to Temps.

## Develop

Open `index.html` in a browser. No build step.

## Deploy

Temps builds the `Dockerfile` and runs it. Caddy listens on `$PORT` (Temps-supplied) or falls back to `:80`.

Local test:

```sh
docker build -t agent-wire-landing .
docker run --rm -p 8080:80 agent-wire-landing
# → http://localhost:8080
```

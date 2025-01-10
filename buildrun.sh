source .env
docker build -t ts-socks-node .
docker run -d --name ts-socks-node -e TAILSCALE_AUTH_KEY=${TAILSCALE_AUTH_KEY} -p 1080:1080 ts-socks-node
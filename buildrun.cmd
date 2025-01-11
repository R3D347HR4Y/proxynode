@echo off
:: Load environment variables from .env file
for /F "tokens=*" %%A in (.env) do set %%A

:: Build the Docker image
docker build -t ts-socks-node .

:: Stop and remove existing container if it exists
docker stop ts-socks-node 2>NUL
docker rm ts-socks-node 2>NUL

:: Run the container
docker run -d ^
    --name ts-socks-node ^
    --restart unless-stopped ^
    --privileged ^
    --cap-add=NET_ADMIN ^
    --cap-add=NET_RAW ^
    -v /dev/net/tun:/dev/net/tun ^
    -e TAILSCALE_AUTH_KEY=%TAILSCALE_AUTH_KEY% ^
    -p 1080:1080 ^
    ts-socks-node

:: Show the container logs
docker logs ts-socks-node 
# Tailscale SOCKS5 Proxy

A Docker container that runs a SOCKS5 proxy through Tailscale, allowing you to set up end nodes to use specific IPs from your server (for testing with Playwright from multiple locations for example)

## Prerequisites

- Docker installed on your system
- A Tailscale account
- A Tailscale auth key (can be generated in the Tailscale admin console)

## Get the image

```bash
docker run -d --name bltv/ts-socks-node -e TAILSCALE_AUTH_KEY=$TAILSCALE_AUTH_KEY -p 1080:1080 bltv/ts-socks-node
```

## Setup

1. Create a `.env` file in the project root:

```env
TAILSCALE_AUTH_KEY=your-auth-key-here
```

2. Build and run the container:

```bash
./buildrun.sh
```

## Usage

Configure your [tailscale balancing SOCKS server](https://github.com/R3D347HR4Y/proxyserver)

## Components

- `Dockerfile`: Sets up Debian with Tailscale and Dante SOCKS proxy
- `danted.conf`: SOCKS5 proxy configuration
- `entrypoint.sh`: Container startup script
- `buildrun.sh`: Build and run helper script

## Security Notes

- The SOCKS5 proxy is configured without authentication
- Traffic is routed through your Tailscale network
- Container exposes port 1080 for testing

## Troubleshooting

1. Verify the container is running:

```bash
docker logs ts-socks-node
```

2. Check Tailscale status:

```bash
docker exec ts-socks-node tailscale status
```

3. Test the proxy connection:

```bash
curl --socks5 localhost:1080 https://ifconfig.me
```

## License

MIT

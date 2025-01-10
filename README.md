# Tailscale SOCKS5 Proxy

A Docker container that runs a SOCKS5 proxy through Tailscale, allowing you to route traffic through your Tailscale network.

## Prerequisites

- Docker installed on your system
- A Tailscale account
- A Tailscale auth key (can be generated in the Tailscale admin console)

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

Configure your applications to use the SOCKS5 proxy:

- Host: `localhost` (or your Docker host IP)
- Port: `1080`
- Protocol: SOCKS5
- No authentication required

### Browser Configuration

**Firefox:**

1. Settings → Network Settings
2. Manual proxy configuration
3. SOCKS Host: `localhost`
4. Port: `1080`
5. Select SOCKS v5
6. Check "Proxy DNS when using SOCKS v5"

**Chrome/Edge:**

1. Settings → System → Network → Proxy settings
2. Manual proxy setup
3. SOCKS Host: `localhost`
4. Port: `1080`

## Components

- `Dockerfile`: Sets up Debian with Tailscale and Dante SOCKS proxy
- `danted.conf`: SOCKS5 proxy configuration
- `entrypoint.sh`: Container startup script
- `buildrun.sh`: Build and run helper script

## Security Notes

- The SOCKS5 proxy is configured without authentication
- Traffic is routed through your Tailscale network
- Container exposes port 1080 for the SOCKS5 proxy

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

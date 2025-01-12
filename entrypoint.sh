#!/bin/bash

# Start Tailscale
echo "Starting Tailscale..."
tailscaled --tun=userspace-networking &
sleep 5 # Wait for Tailscale to start

# Authenticate Tailscale (use authkey for unattended setups)
echo "Authenticating Tailscale..."
if [ -n "$TAILSCALE_AUTH_KEY" ]; then
    tailscale up --authkey=${TAILSCALE_AUTH_KEY} --hostname=${TAILSCALE_HOSTNAME:-"proxy"} --accept-routes --advertise-exit-node
else
    echo "Error: TAILSCALE_AUTH_KEY not provided."
    exit 1
fi

# Verify Tailscale is running
tailscale status


# Start Dante
echo "Starting Dante..."

# Start the SOCKS5 proxy
danted -f /etc/danted.conf
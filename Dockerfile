# Use a lightweight base image
FROM debian:bullseye

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    iptables \
    dnsutils \
    dumb-init \
    dante-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Tailscale
RUN curl -fsSL https://pkgs.tailscale.com/stable/debian/bullseye.gpg | apt-key add - && \
    curl -fsSL https://pkgs.tailscale.com/stable/debian/bullseye.gpg | gpg --dearmor > /usr/share/keyrings/tailscale-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/tailscale-archive-keyring.gpg] https://pkgs.tailscale.com/stable/debian bullseye main" | tee /etc/apt/sources.list.d/tailscale.list && \
    apt-get update && \
    apt-get install -y tailscale && \
    rm -rf /var/lib/apt/lists/*

# Copy the SOCKS5 proxy configuration
COPY danted.conf /etc/danted.conf

# Expose the SOCKS5 port
EXPOSE 1080

# Set up the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Run the entrypoint
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/entrypoint.sh"]
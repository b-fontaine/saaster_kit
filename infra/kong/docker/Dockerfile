FROM kong:latest

# Install dependencies
USER root
RUN apt-get update && \
    apt-get install -y git unzip curl luarocks && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Note: The OIDC plugin is not compatible with this version of Kong
# We've disabled it in the Kong configuration

# Note: The Open AppSec plugin is not available for Lua 5.1
# We've disabled it in the Kong configuration

# Install the Kong gRPC Gateway plugin
RUN luarocks install kong-plugin-grpc-gateway

# Switch back to the kong user
USER kong

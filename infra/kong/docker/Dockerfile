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

# To fix the current LUA issue https://github.com/luarocks/luarocks/issues/1797
# Use PUC-Rio Lua instead of LuaJIT to invoke luarocks (Kong PR #14621 approach)
RUN apt-get update && apt-get install -y lua5.1 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install the Kong gRPC Gateway plugin using PUC-Rio Lua
RUN lua5.1 /usr/bin/luarocks install kong-plugin-grpc-gateway

# Install the Kong SafeLine plugin using PUC-Rio Lua
RUN lua5.1 /usr/bin/luarocks install kong-safeline

# Switch back to the kong user
USER kong

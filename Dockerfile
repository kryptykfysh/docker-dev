# Dockerfile for development machine

# Select Ubuntu as the base image
FROM ubuntu:latest

# Install build tools
RUN apt-get update && apt-get install -y \
    build-essential

# Startup commands
ENTRYPOINT /bin/bash

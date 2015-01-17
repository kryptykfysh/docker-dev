# Dockerfile for development machine

# Select Ubuntu as the base image
FROM ubuntu:latest

# Install build tools
RUN apt-get update -q
RUN apt-get install build-essential

# Startup commands
ENTRYPOINT /bin/bash

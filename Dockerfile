# Dockerfile for development machine

# Select Ubuntu as the base image
FROM ubuntu:latest

# Install build tools
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    wget

# Install and configure rbenv
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN rbenv install 2.2.0

# install ruby-build
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# Startup commands
ENTRYPOINT /bin/bash

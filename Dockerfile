# Dockerfile for development machine

# Select Ubuntu as the base image
FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive

# Install build tools
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    wget \
    autoconf \
    bison \
    libssl-dev \
    libyaml-dev \
    libreadline6-dev \
    zlib1g-dev \
    libncurses5-dev \
    libffi-dev \
    libgdbm3 \
    libgdbm-dev \
    ruby-dev

# Install and configure rbenv
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv && \
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build && \
  git clone https://github.com/sstephenson/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars && \
  . ~/.bashrc && \
  rbenv install 2.2.0 && \
  rbenv rehash && \
  rbenv global 2.2.0 && \
  gem update --system && \
  gem install pry pry-doc activesupport

# Install and configure Vim
RUN apt-get install -y vim-gtk && \
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ADD https://raw.githubusercontent.com/kryptykfysh/vim-config/master/.vimrc /root/.vimrc
ADD https://raw.githubusercontent.com/kryptykfysh/vim-config/master/.vimrc.bundles /root/.vimrc.bundles
ADD https://raw.githubusercontent.com/kryptykfysh/vim-config/master/.vimrc.local /root/.vimrc.local
RUN vim +PluginInstall +qall

# Install tmux
RUN apt-get install ncurses-dev tmux && \
  echo '[[ $- != *i* ]] && return' >> ~/.bashrc && \
  echo '[[ -z "$TMUX" ]] && exec tmux' >> ~/.bashrc

# Install pyenv
RUN apt-get install \
  libbz2-dev \
  libsqlite3-dev && \
  git clone https://github.com/yyuu/pyenv.git ~/.pyenv && \
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc && \
  echo 'eval "$(pyenv init -)"' >> ~/.bashrc && \
  . ~/.bashrc && \
  pyenv install 2.7.8 && \
  pyenv rehash

# Install Nodenv
RUN git clone https://github.com/OiNutter/nodenv.git ~/.nodenv && \
  echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.bashrc && \
  echo 'eval "$(nodenv init -)"' >> ~/.bashrc && \
  mkdir ~/.nodenv/plugins && \
  git clone git://github.com/OiNutter/node-build.git ~/.nodenv/plugins/node-build && \
  git clone https://github.com/OiNutter/nodenv-vars.git ~.nodenv/plugins/nodenv-vars && \
  . ~/.bashrc && \
  nodenv install 0.11.13

# Startup commands
ENTRYPOINT /bin/bash


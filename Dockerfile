# Dockerfile for development machine

# Select Ubuntu as the base image
FROM ubuntu:16.10
ENV DEBIAN_FRONTEND noninteractive

# Install build tools and client packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
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
    ncurses-dev \
    tmux \
    libbz2-dev \
    libsqlite3-dev \
    vim-gtk \
    ruby-dev && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
  echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' >> /etc/apt/sources.list.d/pgdg.list && \
  apt-get update && apt-get install -y postgresql-client libpq-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install and configure rbenv
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv && \
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build && \
  git clone https://github.com/sstephenson/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars && \
  . ~/.bashrc && \
  rbenv install 2.4.1 && \
  rbenv rehash && \
  rbenv global 2.4.1 && \
  gem update --system && \
  gem install bundler rails pry pry-doc rubocop reek flay

# Install and configure Vim
RUN git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ADD https://raw.githubusercontent.com/kryptykfysh/vim-config/master/.vimrc /root/.vimrc
ADD https://raw.githubusercontent.com/kryptykfysh/vim-config/master/.vimrc.bundles /root/.vimrc.bundles
ADD https://raw.githubusercontent.com/kryptykfysh/vim-config/master/.vimrc.local /root/.vimrc.local
RUN vim +PluginInstall +qall

# Add Ozzie's groovy PS1 prompt
RUN git clone --recursive https://github.com/ian-ozzie/ps1.git ~/.ps1 && \
  echo '[ -e $HOME/.ps1/ps1.bash ] && source $HOME/.ps1/ps1.bash' >> ~/.bashrc

# Install pyenv
RUN git clone https://github.com/yyuu/pyenv.git ~/.pyenv && \
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc && \
  echo 'eval "$(pyenv init -)"' >> ~/.bashrc && \
  . ~/.bashrc && \
  pyenv install 2.7.8 && \
  pyenv rehash && \
  pyenv global 2.7.8

# Install Nodenv
RUN git clone https://github.com/OiNutter/nodenv.git ~/.nodenv && \
  echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.bashrc && \
  echo 'eval "$(nodenv init -)"' >> ~/.bashrc && \
  mkdir ~/.nodenv/plugins && \
  git clone git://github.com/OiNutter/node-build.git ~/.nodenv/plugins/node-build && \
  git clone https://github.com/OiNutter/nodenv-vars.git ~/.nodenv/plugins/nodenv-vars && \
  . ~/.bashrc && \
  nodenv install 7.2.0 && \
  nodenv rehash && \
  nodenv global 7.2.0 && \
  npm install -g npm && \
  npm install -g bower && \
  npm install -g ember

# Startup commands
ENTRYPOINT /bin/bash


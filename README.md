# Docker-Dev

This was just me messing around with Docker to replicate my home development build.
It's an Ubuntu base with VIM text editor and Ruby, Python and Node environments.

## Installation

### From Build Script

This is the slower option, manually building the image from the Dockerfile.

```
sudo docker build -t <your user>/docker-dev git://github.com/kryptykfysh/docker-dev
```

### From DockerHub

This is faster than above as you're downloading a pre-built image.

```
sudo docker pull kryptykfysh/docker-dev
```

## Running the Container

```
sudo docker run -i -t kryptykfysh/docker-dev
```

The ENTRYPOINT for the container is set to load tmux by default. You can avoid
this by appending /bin/bash to the command above.

## Packages

### TMUX

[Tmux](http://tmux.sourceforge.net/) is a terminal multiplexer. If you don't
want to read the documentation, a good cheatsheet can be found [here](https://gist.github.com/MohamedAlaa/2961058).

### VIM

The [vim](http://www.vim.org/) version installed is the GTK version, which
means +clipboard is enabled. The full set of configuration options is given in
[this repository](https://github.com/kryptykfysh/vim-config).

### Rbenv

[Rbenv](https://github.com/sstephenson/rbenv) is a Ruby version manager.

The following packages are also installed:

  * [ruby-build](https://github.com/sstephenson/ruby-build/issues/156)
  * [rbenv-vars](https://github.com/sstephenson/rbenv-vars)

The image has ruby 2.2.0 as the default version.

### Pyenv

[Pyenv](https://github.com/yyuu/pyenv) is a Python version manager.

The image has Python 2.7.8 as the default version.

### Nodenv

[Nodenv](https://github.com/OiNutter/nodenv) is A Node.js version manager.

The following packages are also installed:

  * [node-build](https://github.com/OiNutter/node-build)
  * [nodenv-vars](https://github.com/OiNutter/nodenv-vars)

The image has Node.js 0.11.13 as the default version.


ARG base
FROM ${base}

USER gitpod

# Dazzle does not rebuild a layer until one of its lines are changed. Increase this counter to rebuild this layer.
ENV TRIGGER_REBUILD=1

# Install latest stable neovim
RUN sudo add-apt-repository ppa:neovim-ppa/stable \
  && sudo apt-get update \
  && sudo apt-get install neovim

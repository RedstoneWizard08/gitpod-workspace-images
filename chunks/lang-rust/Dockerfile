ARG base
FROM ${base}

USER gitpod

# Dazzle does not rebuild a layer until one of its lines are changed. Increase this counter to rebuild this layer.
ENV TRIGGER_REBUILD=1

ENV PATH=$HOME/.cargo/bin:$PATH
RUN cp $HOME/.profile $HOME/.profile_orig \
    && curl -fsSL https://sh.rustup.rs | sh -s -- -y --profile minimal --default-toolchain 1.60.0 \
    && rustup component add \
        rls \
        rust-analysis \
        rust-src \
        rustfmt \
        clippy \
    && rustup completions bash | sudo tee /etc/bash_completion.d/rustup.bash-completion > /dev/null \
    && rustup completions bash cargo | sudo tee /etc/bash_completion.d/rustup.cargo-bash-completion > /dev/null \
    && printf '%s\n' "$(grep -v -F -x -f $HOME/.profile_orig $HOME/.profile)" \
                        'mkdir -m 0755 -p "${CARGO_HOME:-/workspace/.cargo}" 2>/dev/null' \
                        'export CARGO_HOME=/workspace/.cargo' \
                        'export PATH=$CARGO_HOME/bin:$PATH' > $HOME/.bashrc.d/80-rust \
    && _rustup_path="$(command -v rustup)" && mv "$_rustup_path" "${_rustup_path}.main" \
    && printf '%s\n' '#!/usr/bin/bash -eu' \
                        'exec env -u CARGO_HOME "$(command -v rustup.main)" "$@"' > "$_rustup_path" \
    && chmod 0755 "$_rustup_path" && rm $HOME/.profile_orig

RUN cargo install cargo-watch cargo-edit cargo-workspaces

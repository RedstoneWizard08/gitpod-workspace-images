ARG FULL_IMAGE
FROM ${FULL_IMAGE}

RUN bash -cl "cargo install wasm-pack cargo-wasm cargo-generate \
    && curl -fsSL https://wasmtime.dev/install.sh  | bash; \
       rustup target add wasm32-wasi"

RUN install-packages git make clang cmake ninja-build \
    && mkdir /tmp/wasm-sdk \
    && cd /tmp/wasm-sdk \
    && git clone --recursive https://github.com/WebAssembly/wasi-sdk.git . \
    && NINJA_FLAGS=-v make package

RUN git clone --depth 1 "https://github.com/emscripten-core/emsdk.git" $HOME/.emsdk \
    && cd $HOME/.emsdk \
    && ./emsdk install latest \
    && ./emsdk activate latest \
    && printf "\nsource $HOME/.emsdk/emsdk_env.sh\nclear\n" >> ~/.bashrc

RUN brew install binaryen wabt && brew install wasm-pack && rustup target add wasm32-unknown-unknown

ARG DART_VERSION="2.12.4"
ARG FULL_IMAGE

# See https://medium.com/flutter-community/running-dart-on-arm-servers-7fd5f5eb99d - this is a
# modified version of that image. - RedstoneWizard08
FROM ${FULL_IMAGE}

ENV PATH=/usr/lib/dart/bin:$PATH

USER root
WORKDIR /tmp

RUN apt-get -q update && apt-get install --no-install-recommends -y -q \
    gnupg2 curl git ca-certificates unzip openssh-client && \
    case "$(uname -m)" in armv7l | armv7) ARCH="arm";; aarch64) ARCH="arm64";; *) ARCH="x64";; esac && \
    curl -O https://storage.googleapis.com/dart-archive/channels/stable/release/$DART_VERSION/sdk/dartsdk-linux-$ARCH-release.zip && \
    unzip dartsdk-linux-$ARCH-release.zip -d /usr/lib/ && \
    rm dartsdk-linux-$ARCH-release.zip && \
    mv /usr/lib/dart-sdk /usr/lib/dart

ENV DART_SDK=/usr/lib/dart
ENV PATH=$DART_SDK/bin:/root/.pub-cache/bin:$PATH

ARG FULL_VNC_IMAGE
FROM ${FULL_VNC_IMAGE}

ENV ANDROID_HOME=/home/gitpod/android-sdk-linux \
    ANDROID_VERSION=3.3.0.20 \
    FLUTTER_HOME=/home/gitpod/flutter \
    FLUTTER_VERSION=2.2.3-stable

USER root

# Download and install Dart
# See https://medium.com/flutter-community/running-dart-on-arm-servers-7fd5f5eb99d - this is a
# modified version of that image. - RedstoneWizard08
ARG DART_VERSION="2.12.4"
RUN apt-get -q update && apt-get install --no-install-recommends -y -q \
    gnupg2 curl git ca-certificates unzip openssh-client wget && \
    case "$(uname -m)" in armv7l | armv7) ARCH="arm";; aarch64) ARCH="arm64";; *) ARCH="x64";; esac && \
    curl -O https://storage.googleapis.com/dart-archive/channels/stable/release/$DART_VERSION/sdk/dartsdk-linux-$ARCH-release.zip && \
    unzip dartsdk-linux-$ARCH-release.zip -d /usr/lib/ && \
    rm dartsdk-linux-$ARCH-release.zip && \
    mv /usr/lib/dart-sdk /usr/lib/dart

ENV DART_SDK=/usr/lib/dart
ENV PATH=$DART_SDK/bin:/root/.pub-cache/bin:$PATH

USER gitpod

# Download Flutter
RUN cd /home/gitpod \
    && wget -qO flutter_sdk.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}.tar.xz \
    && tar -xvf flutter_sdk.tar.xz && rm flutter_sdk.tar.xz

# Download Android Studio
RUN cd /home/gitpod \
    && wget -qO android_studio.zip https://dl.google.com/dl/android/studio/ide-zips/${ANDROID_VERSION}/android-studio-ide-182.5199772-linux.zip \
    && unzip android_studio.zip && rm -f android_studio.zip

# Setup Android Command Tools (sdkmanager)
RUN cd /home/gitpod \
    && wget -qO commandlinetools.zip https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip \
    && unzip commandlinetools.zip \
    && yes | cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_HOME --licenses \
    && cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "build-tools;28.0.3" "platforms;android-28" \
    && cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_HOME --install "cmdline-tools;latest" \
    && rm commandlinetools.zip

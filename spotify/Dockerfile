ARG BUILD_FROM=hassioaddons/ubuntu-base:5.2.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
# hadolint ignore=DL3003
RUN \
    apt-get update \
    \
    && apt-get install -y --no-install-recommends \
        build-essential=12.4ubuntu1 \
        cargo=0.44.1-0ubuntu1~18.04.1 \
        git=1:2.17.1-1ubuntu0.7 \
        libasound2-data=1.1.3-5ubuntu0.5 \
        libasound2-dev=1.1.3-5ubuntu0.5 \
        libasound2-plugins=1.1.1-1ubuntu1 \
        libasound2=1.1.3-5ubuntu0.5 \
        libssl-dev=1.1.1-1ubuntu2.1~18.04.6 \
        pkg-config=0.29.1-0ubuntu2 \
        rustc=1.43.0+dfsg1+llvm-1~exp1ubuntu2~18.04.1 \
    \
    && git clone --branch "v0.2.24" --depth=1 \
        https://github.com/Spotifyd/spotifyd.git /tmp/spotifyd \
    \
    && cd /tmp/spotifyd \
    && cargo build --release \
    && mv /tmp/spotifyd/target/release/spotifyd /usr/bin \
    \
    && apt-get purge -y --auto-remove \
        build-essential \
        cargo \
        git \
        libasound2-dev \
        libssl-dev \
        pkg-config \
        rustc \
    \
    && rm -fr \
        /tmp/* \
        /root/.cargo \
        /var/{cache,log}/* \
        /var/lib/apt/lists/*

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Spotify Connect" \
    io.hass.description="Play Spotify music on your Home Assistant device" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.title="Spotify Connect" \
    org.opencontainers.image.description="Play Spotify music on your Home Assistant device" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/hassio-addons/addon-spotify-connect" \
    org.opencontainers.image.documentation="https://github.com/hassio-addons/addon-spotify-connect/blob/master/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

ARG BUILD_FROM=hassioaddons/ubuntu-base:3.1.3
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
        cargo=0.33.0-1ubuntu1~18.04.1 \
        git=1:2.17.1-1ubuntu0.4 \
        libasound2-data=1.1.3-5ubuntu0.2 \
        libasound2-dev=1.1.3-5ubuntu0.2 \
        libasound2=1.1.3-5ubuntu0.2 \
        libssl-dev=1.1.1-1ubuntu2.1~18.04.3 \
        pkg-config=0.29.1-0ubuntu2 \
        rustc=1.32.0+dfsg1+llvm-1ubuntu1~18.04.1 \
    \
    && git clone --branch "0.2.11" --depth=1 \
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
    org.label-schema.description="Play Spotify music on your Home Assistant device" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Spotify Connect" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://community.home-assistant.io/t/community-hass-io-add-on-spotify-connect/61210?u=frenck" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-spotify-connect/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-spotify-connect" \
    org.label-schema.vendor="Community Hass.io Add-ons"

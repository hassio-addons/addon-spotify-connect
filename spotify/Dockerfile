ARG BUILD_FROM=hassioaddons/ubuntu-base-amd64:2.0.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Setup base
# hadolint ignore=DL3003,DL3008,SC2039
RUN \
    apt-get update \
    \
    && apt-get install -y --no-install-recommends \
        cargo \
        git \
        libasound2-dev \
        libasound2 \
        libssl-dev \
        rustc \
        build-essential \
        pkg-config \
    \
    && git clone --branch "v0.2.2" --depth=1 \
        https://github.com/Spotifyd/spotifyd.git /tmp/spotifyd \
    \
    && cd /tmp/spotifyd \
    && cargo build --release \
    && mv /tmp/spotifyd/target/release/spotifyd /usr/bin \
    \
    && apt-get purge -y --auto-remove \
        cargo \
        git \
        libasound2-dev \
        libssl-dev \
        rustc \
        build-essential \
        pkg-config \
    \
    && rm -f -r /tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/* \
    && rm -rf /var/{cache,log}/*/*

# Copy root filesystem
COPY rootfs /

# Build arugments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Spotify Connect" \
    io.hass.description="Lorem ipsum" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.label-schema.description="Lorem ipsum" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Spotify Connect" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://community.home-assistant.io/?u=frenck" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-spotify-connect/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-spotify-connect" \
    org.label-schema.vendor="Community Hass.io Add-ons"

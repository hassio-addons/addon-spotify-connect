ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:9.2.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
# hadolint ignore=DL3003
RUN \
    apk add --no-cache --virtual .build-dependencies \
        build-base=0.5-r2 \
        cargo=1.47.0-r2 \
        pulseaudio-dev=14.1-r0 \
    \
    && apk add --no-cache \
        pulseaudio=14.1-r0 \
    \
    && curl -J -L -o /tmp/librespot.tar.gz \
        "https://github.com/librespot-org/librespot/archive/v0.2.0.tar.gz" \
    \
    && mkdir /tmp/librespot \
    && tar zxvf \
        /tmp/librespot.tar.gz \
        --strip 1 -C /tmp/librespot \
    \
    && export RUSTFLAGS="-C target-feature=-crt-static" \
    && export CARGO_HOME="/tmp/librespot/cargo" \
    \
    && cd /tmp/librespot \
    && cargo build \
        --locked \
        --no-default-features \
        --features pulseaudio-backend \
        --release \
        --verbose \ 
    \
    && mv /tmp/librespot/target/release/librespot /usr/bin/librespot \
    \
    && apk del --no-cache --purge .build-dependencies \
    && rm -fr /tmp/*

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

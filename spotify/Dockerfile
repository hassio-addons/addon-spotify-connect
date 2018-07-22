ARG BUILD_FROM=hassioaddons/base:2.0.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Add env
ENV TERM="xterm-256color"

# Setup base
ARG BUILD_ARCH
# hadolint ignore=DL3003
RUN \
    && apk add --no-cache --virtual .build-dependencies \
        alsa-lib-dev=1.1.6-r0 \
        build-base=0.5-r1 \
        cargo=1.26.2-r0 \
        rust=1.26.2-r0 \
        git=2.18.0-r0 \
        libressl-dev=2.7.4-r0 \
    \
    && apk add --no-cache \
        alsa-lib=1.1.6-r0 \
    \
    && git clone --branch "v0.2.2" --depth=1 \
        https://github.com/Spotifyd/spotifyd.git /tmp/spotifyd \
    \
    && cd /tmp/spotifyd \
    && cargo build --release \
    && mv /tmp/spotifyd/target/release/spotifyd /usr/bin \
    \
    && rm -f -r /tmp/* \
    && apk del --purge .build-dependencies

# Copy root filesystem
COPY rootfs /

# Build arugments
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

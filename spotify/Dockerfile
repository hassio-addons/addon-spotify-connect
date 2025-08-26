ARG BUILD_FROM=ghcr.io/hassio-addons/base:18.0.2
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
ARG LIBRESPOT_VERSION="0.7.0"
# hadolint ignore=DL3003
RUN \
    apk add --no-cache --virtual .build-dependencies \
        build-base=0.5-r3 \
        cargo=1.87.0-r0 \
        git=2.49.1-r0 \
        protobuf-dev=29.4-r0 \
        pulseaudio-dev=17.0-r5 \
        cmake=3.31.7-r1 \
        clang19-libclang=19.1.7-r6 \
    \
    && apk add --no-cache \
        pulseaudio=17.0-r5 \
    \
    && cargo install --force --locked bindgen-cli \
    && export PATH="$HOME/.cargo/bin:$PATH" \
    && cargo install \
        --locked \
        --no-default-features \
        --features "pulseaudio-backend with-libmdns" \
        --root /usr \
        --bin librespot \
        --version "${LIBRESPOT_VERSION}" \
        --verbose \ 
        -- librespot \
    \
    && cargo uninstall bindgen-cli \
    && apk del --no-cache --purge .build-dependencies \
    && rm -fr \
        /tmp/* \
        ~/.cargo \
        /usr/.crates.toml \
        /usr/.crates2.json

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

#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Spotify Connect
# This files check if all user configuration requirements are met
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

if ! hass.config.has_value 'username'; then
    hass.die 'Setting your Spotify username is required!'
fi

if ! hass.config.has_value 'password'; then
    hass.die 'Setting your Spotify password is required!'
fi

if ! hass.config.has_value 'name'; then
    hass.die 'You need to give you Spotify player a name!'
fi

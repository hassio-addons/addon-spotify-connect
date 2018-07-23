#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Spotify Connect
# Sets up the configuration file for spotifyd
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

declare username
declare password
declare name
declare bitrate

username=$(hass.config.get 'username')
password=$(hass.config.get 'password')
name=$(hass.config.get 'name')
bitrate=$(hass.config.get 'bitrate')

{
    echo "username = \"${username}\""
    echo "password = \"${password}\""
    echo "device_name = \"${name}\""
    echo "bitrate = ${bitrate}"
} >> /etc/spotifyd.conf

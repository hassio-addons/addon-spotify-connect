#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Spotify Connect
# Sets up the configuration file for spotifyd
# ==============================================================================
declare username
declare password
declare name
declare bitrate

username=$(bashio::config 'username')
password=$(bashio::config 'password')
name=$(bashio::config 'name')
bitrate=$(bashio::config 'bitrate')

{
    echo "username = \"${username}\""
    echo "password = \"${password}\""
    echo "device_name = \"${name}\""
    echo "bitrate = ${bitrate}"
} >> /etc/spotifyd.conf

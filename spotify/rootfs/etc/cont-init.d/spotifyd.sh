#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Spotify Connect
# Sets up the configuration file for spotifyd
# ==============================================================================
declare username
declare password
declare name
declare bitrate
declare initial_volume

if ! bashio::config.has_value 'name'; then
    bashio::log.fatal
    bashio::log.fatal "Add-on configuration is incomplete!"
    bashio::log.fatal
    bashio::log.fatal "The Spotify client needs to be identifiable with a name"
    bashio::log.fatal "and it seems you haven't configured one."
    bashio::log.fatal
    bashio::log.fatal "Please set the 'name' add-on option."
    bashio::log.fatal
    bashio::exit.nok
fi

if bashio::config.has_value 'username'; then
    bashio::config.require.password
    username=$(bashio::config 'username')
    password=$(bashio::config 'password')
    {
        echo "username =${username}"
        echo "password =${password}"
    } >> /etc/spotifyd.conf
fi

name=$(bashio::config 'name')
bitrate=$(bashio::config 'bitrate')
{
    echo "device_name =${name}"
    echo "bitrate =${bitrate}"
} >> /etc/spotifyd.conf

if bashio::config.has_value 'initial_volume'; then
    initial_volume=$(bashio::config 'initial_volume')
    {
        echo "initial_volume =${initial_volume}"
    } >> /etc/spotifyd.conf
fi

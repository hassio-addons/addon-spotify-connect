#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Spotify Connect
# Sets up the configuration file for spotifyd
# ==============================================================================
declare username
declare password
declare name
declare bitrate

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

if bashio::config.has_value 'status_entity'; then
    status_entity=$(bashio::config 'status_entity')
    echo "on_song_change_hook = /usr/bin/song_change_hook.sh" >> /etc/spotifyd.conf
    {
        echo "#!/bin/bash"
        echo "curl -X POST -H \"Authorization: Bearer \${SUPERVISOR_TOKEN}\" -H \"Content-Type: application/json\" -d \"{\\\"state\\\": \\\"\$PLAYER_EVENT\\\", \\\"attributes\\\": {\\\"track_id\\\": \\\"\$TRACK_ID\\\"}}\" http://supervisor/core/api/states/${status_entity}"
    } > /usr/bin/song_change_hook.sh
    exec chmod a+x /usr/bin/song_change_hook.sh
fi

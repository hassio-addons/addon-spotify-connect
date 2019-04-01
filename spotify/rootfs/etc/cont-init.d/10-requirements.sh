#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Spotify Connect
# This files check if all user configuration requirements are met
# ==============================================================================
bashio::config.require.username
bashio::config.require.password

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

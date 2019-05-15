#!/bin/bash

# Remove Any Old Run Files
rm -rf /var/run/*
if [ -f "/config/Library/Application Support/Plex Media Server/plexmediaserver.pid" ];
then
	rm -f "/config/Library/Application Support/Plex Media Server/plexmediaserver.pid"
fi

# Run Plex Media Server Script
/usr/local/bin/start_pms.sh
sleep 5

# Tail Logs To Terminal
tail -f "/config/Library/Logs/Plex Media Server/Plex Media Server.log" "/config/Library/Logs/Plex Media Server/Plex DLNA Server.log"

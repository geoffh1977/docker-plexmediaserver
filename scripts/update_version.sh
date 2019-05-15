#!/bin/bash
# Update The Software Version From Online

[ ! -z $1 ] && PLEX_AUTH="-u ${1}:${2}"

# Get The Versions Of The Software
SITE_VERSION=$(curl -s ${PLEX_AUTH} "https://plex.tv/downloads/details/1?build=linux-ubuntu-x86_64&channel=32&distro=ubuntu" | grep -Po '(?<=(\" version=\"))(\S+)(?=(\"))')
LOCAL_VERSION=$(grep "finalImageVersion" config.yml | cut -d: -f 2 | sed 's/ //g')

# Check Versions And Update File
if [ "$SITE_VERSION" != "$LOCAL_VERSION" ]
then
  sed -i "s/^finalImageVersion:.*/finalImageVersion: ${SITE_VERSION}/" config.yml
  echo "Version Updated. New Version Set To ${SITE_VERSION}"
else
  echo "No Version Change Required."
fi

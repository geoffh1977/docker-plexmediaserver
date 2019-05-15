# Plex Media Server Container #

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/geoffh1977/plexmediaserver.svg?style=plastic)
![GitHub](https://img.shields.io/github/license/geoffh1977/docker-plexmediaserver.svg?style=plastic)

## Description ##
This docker image provides the publically available version of Plex Media Server.

The code allows for Plex Pass users to build the latest version also. However, out of respect for the Plex project only the free version is supplied here.

## Starting Consul Server ##
The easiest way to start the container is by connecting it directly to the host. This allows for DLNA to located the server.

`docker run --rm --name PlexMediaServer --net host -v /var/lib/plexmediaserver/config:/config -v /mnt/tank/media/public:/media geoffh1977/plexmediaserver:1.15.4.994-107756f7e`

## Data Persistence And Configs ##
In order to maintain data persistence across service restarts, you can mount a volume or host share on the "/media" and "/config" paths within the container.

## Downloading The Plex Media Server Container ##
This repository is connected to Docker Hub - so you will always find the latest builds there. Execute the _docker pull_ command in order to get the required image:

* geoffh1977/plexmediaserver:latest - The latest build of the application that was completed
* geoffh1977/plexmediaserver:1.15.4.994-107756f7e - An exact version of the application

## Building The Plex Media Server Container ##
After cloning the repository, simply execute the _make build_ command while in the repository root path to execute a docker build of the current Dockerfile. The Makefile contains a number of useful commands which perform different actions.

### To Build Plex Pass ###
To build the Plex Pass edition, Clone the repository and modify the config.yml file with your Plex Credentials.

Execute the commands:

```
    make update-version
    make build
```

### Getting In Contact ###
If you find any issues with this container or want to recommend some improvements, fell free to get in contact with me or submit pull requests on github.

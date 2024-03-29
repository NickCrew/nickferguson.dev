+++
author = "Nick Ferguson"
title = "Automated Media Management"
date = "2021-07-23"
draft = true
summary = "A repo with instructions for automating tracking and downloading of movies, TV, music and eBooks along with friendly frontends for browsing and requesting new content. Based on the *arr apps and Calibre eBook manager."
tags = ["docker","pvr","entertainment","home automation"]
categories = ["Tutorials"]
+++

A repo to assist in quickly getting an automated PVR system up and running.

---

## References

- [WikiArr](https://wiki.servarr.com/)
- [NickCrew/auto-htpc](https://github.com/NickCrew/auto-htpc)

---

## Components

### Indexer and Tracker

- [Prowlarr](https://github.com/Prowlarr/Prowlarr)

Indexer manager that integrates well with the other _*arr_ apps and does not require per-app setup. Rather, the indexers and trackers are pushed to the individual apps.  

__Alternative:__ [Jackett](https://github.com/Jackett/Jackett)

### PVRs

- [Sonarr](https://github.com/Sonarr/Sonarr) (TV Series and Anime)
- [Radarr](https://github.com/Radarr/Radarr) (Movies) 
- [Lidarr](https://github.com/Lidarr/Lidarr) (Music)
- [Readarr](https://github.com/Readarr/Readarr) (eBooks)

These apps will monitor feeds for your requested content and when found will grab, sort and rename them. 

### Calibre 

- [Calibre](https://hub.docker.com/r/linuxserver/calibre)
- [Calibre Web](https://hub.docker.com/r/linuxserver/calibre-web)

If you have many eBooks, you're probably familiar with Calibre. Readarr can connect to a Calibre instance for eBook library management.  

The Calibre app is accessed through Guacamole on port `18080` in this configuration and should look familiar if you've used the desktop application. Open `Preferences` => `Share over network` and enable the calibre server so you can connect from Readarr.  

Calibre Web is optional, but can be a nice addition. It does not provide all of the same features as the regular Calibre app because it is primarily a library browser. One nice thing about Calibre Web is that it supports multiple user accounts. You can also upload/download from the web interface, as well as edit metadata.



### Requests Manager

- [Overseerr](https://github.com/sct/overseerr) 

This application allows you or your users to search for, discover and request TV shows, Anime and Movies. It connects to Sonarr and Radarr so that requests are automatically added to the respective app.


__Alternative:__ [Ombi](https://github.com/Ombi-app/Ombi)  
Overseerr is a newer application, but I prefer its interface and configuration to Ombi.

### Download Client and VPN

- [Transmission+OpenVPN](https://github.com/haugene/docker-transmission-openvpn)
	
OpenVPN client container with [Transmission](https://transmissionbt.com) included. Most users will want their download client traffic to only a VPN connection, but this is not strictly required.  
I am using [Private Internet Access](https://github.com/haugene/docker-transmission-openvpn) as a VPN.  


__Alternative:__ [Qbittorrent+OpenVPN](https://hub.docker.com/r/guillaumedsde/qbittorrent-openvpn)  
I have not used this container/client combo, but it looks like it would suffice if you prefer [Qbit](https://hub.docker.com/r/linuxserver/qbittorrent) to Transmission, as many people do.


---

## Prerequisites

Clone the repository to get started
````bash
git clone https://github.com/NickCrew/auto-htpc.git
````

> All commands given are relative to the top-level repo directory


### Docker

1. [Install Docker](https://docs.docker.com/engine/install/ubuntu/)
2. [Install Docker Compose](https://docs.docker.com/compose/install/)


### Environment

Environment variables shared by multiple containers or those containing sensitive information are set externally using `*.env` files.

#### Common

Generate a new `common.env` file with the following commands 

````bash
echo TZ=$(timedatectl status | awk 'FNR == 4' | awk '{print $3}') > common.env
echo PUID=$(id -u) >> common.env
echo PGID=$(id -g) >> common.env
````

#### VPN

If you're using the Transmission/OpenVPN container, you can use the included `vpn.env.sample` to create the `vpn.env` file. At a minimum, you will need to modify `OPENVPN_USERNAME=` and `OPENVPN_PASSWORD=`.

````bash
cp vpn.env.sample vpn.env
````

__You will need to add any OpenVPN profiles (`*.ovpn`) under `transmission-openvpn-data/`.__

### Docker Volumes

In my setup, media and downloads are stored on a Synology NAS, while my this repo and the service configuration files are stored on the same Intel NUC hosting my Plex server. This lets me manage the backups and large volume storage on the NAS and keep versioned configuration files in this repo.  

You can opt to use bind mounts for all volumes, in the same way a configuration folder is done. Don't forget to remove the NFS elements for any volumes you replace in this way. For example:

````yml
volumes:
  - $PWD/downloads:/downloads
````

If you choose to also use NFS volumes, you will need to modify these two values for each element:
````yml
volumes:
  downloads:
    driver_opts:
	  type: nfs
	  o: "addr=<nfs_server_url>,nolock,rw,soft"
	  device: ":/<nfs_share_path>"
````

--- 

## Usage

Please see the [Docker Compose Documentation](https://docs.docker.com/compose/gettingstarted/) for more information on using compose.

### Launch Services

````bash
docker-compose up -d
````

### Stop Services
````bash
docker-compose down
````

### Test VPN Connectivity

To ensure your VPN connection is working you can see what the Transmission container's reported IP is like so:

````bash
docker exec -it transmission curl ifconfig.me/ip
````

### Saving Configuration

Any bind mounts, such as for the config directories, will be created on start up. Once they are created you can commit your config. A `.gitignore` is already provided to help you to only commit what's needed to preserve your configuration. 

````bash
git add .
git commit -m 'saving initial config'
````

You will probably want to push back to your repo. 
You can skip the first step if you don't wish to preserve this repo as an upstream remote.

````bash
git remote add upstream https://github.com/NickCrew/auto-htpc.git
git remote set-url origin <your_git_remote_url>
git fetch
git push -u origin master
````





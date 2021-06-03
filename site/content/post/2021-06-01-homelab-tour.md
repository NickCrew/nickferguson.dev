{
    "title": "Home Network Tour",
    "date": "2021-06-01"
}


An overview of my home network, lab and development environment.

---

## Gear

![Network Cabinet Zoomed Out](/img/netcabinet_small.jpg)

### Network

As part of an ancient quest to spend less time maintaining a more reliable home network, I went all-in on Unifi this year. I am not a total stranger to Ubiquiti; previously I was using an Edgerouter X, however I also upgraded my internet to a symmetric gigabit connection and that was more than the poor little ER-X could handle.  

![Network Cabinet](/img/netcabinetfull_small.jpg)

Despite many a tale of woe on Reddit and the Internet, I chose to start with an Unifi Dream Machine Pro (UDMP) and I'm glad I did because it has been solid for me and while the EdgeOS has more raw capabilities, I found the UDMP to do everything I needed and without extensive configuring.


The full Unifi setup includes: 
- __Dream Machine Pro__ (UDMP)
- __USW-16-PoE__ (gigabit switch with 2x SFP)
- __U6-Lite__ (Wifi 6 access point)
- __UAP-AC-Lite__ (Wifi 5 access point)

![Unifi Gear](/img/unifigear_small.jpg)

### Storage

I have a __Synology DS720+__ that enjoys 'appliance' status on the network. In addition to normal storage, production services with stricter availability requirements run on this device in Dcker containers.

Despite many reports that it can handle up to 16GB of memory, I run my DS720+ with only the max recommended memory of 6GB and I still find it very capable. I try to keep the NAS fairly reliable so I will usually put normal production services here if they are not too resource intensive and can be run in docker containers. I also take advantage of several Synology packages to provide core services. I tend to view my NAS as an appliance and I treat the services it hosts similarly.

### Compute

For production services with higher memory or CPU requirements, I am using a __NUC8i3BEH__ with 16GB memory and 2 256GB SSDs in RAID-1.

![Syno720 and NUC8i3BEH](/img/syno_nuc_small.jpg)

---

## Services

I used to run much larger servers but these days I find that I really value quiet devices with a small footprint. As
you can see, you can run *a lot* of services on relatively light hardware if you plan it right.

The following are all of my "production" services and they only consume about 20% of the overall available resources on my
network which leaves plenty left over for mad science experiments. If I needed more resources I would probably add
another NUC or similar mini/micro/tiny machine.


### Availability Levels

> I tend to use loose tiered model to categorize the services on my home network and this usually determines host(s) it on and how it is deployed.  
> 1. __Critical__ If these services go down the entire network is broken. There is wailing and gnashing of teeth.
> 2. __Normal__ Apps used daily but are unlikely to invoke the wrath of the household if they are down for a short period. _(e.g.Entertainment and media organization)_
> 3. __Lab__ Experimental projects and services.


### UDM Pro Containers

![Unifi Gear Closeup](/img/unifigear2_small.jpg)

The UDMP can run containers via `podman` (see: [udm-utilities](https://github.com/boostchicken/udm-utilities)).
I have containers for the following:

- Pihole for local DNS resolution and Ad blocking
- Cloudflare Dynamic DNS update
- LetsEncrypt renewal for the domain pointing home

I prefer Pihole on the UDMP as it is a critical service and if the UDMP is down then I likely have bigger problems anyway.


### Personal Organization Services

#### DS Notes, Photo Station and Moments
I actually like several of the apps made by Synology, including DS Note. If they would add support
  for code syntax highlight it would be literally perfect. I also find the photo apps do everything I need
  and so I have stuck with them in addition to iCloud.


#### Paperless-ng
A document management application with indexing and OCR. Documents can be added by placing them in a watched folder on the NAS or by emailing them to a special mailbox with various rules applied depending on names and email subjects.  

I am trying to go completely paperless which is a tough habit to form in the beginning. Right now I am scanning documents with my phone but I would like to get a nice desktop scanner capable of doing two-sided documents.  


[Paperless-ng](https://github.com/jonaswinkler/paperless-ng) learns and improves over time with the more documents you
feed it so while I am doing a fair bit of manual tagging and naming now, my hope is it becomes more capable in
handling at least basic document types like receipts on its own eventually.

#### Filebot
This is a NodeJS application which provides a web interface to [Filebot](https://filebot.net), a tool to automatically rename movies, TV shows, music and anime. I use this to format file and folder names for the best possible compatibility with Plex

#### Transmission + OpenVPN

Transmission is my favorite bittorrent client because its simple and has a nice remote web interface. I have a
subscript to PIA (Personal Internet Access) VPN which I use with this [Docker image that combines Transmission and OpenVPN](https://hub.docker.com/r/haugene/transmission-openvpn/).

#### Calibre-Web
[Calibre-Web](https://github.com/janeczku/calibre-web) is a web application based on Calibre that provides an eBook library. For the most part this has replaced the traditional Calibre desktop application for me.

#### Homebridge
I really like the iOS Home app, but unfortunately none of my home automation devices are natively supported.
[Homebridge](https://homebridge.io) "bridges" the gap between many home automation products and the iOS Home app. This
lets me control all of my TP-Link plugs and lights, Ring cameras and alarms, Roomba and Echo devices all from the same app.

#### Homer
I use [Homer](https://github.com/bastienwirtz/homer) to create a home page for my local network. While I do use local
DNS records, the number of services I'm running has grown to the point that it is nice to have a single paging for
discovery and links. This app is dead simple to configure using YAML and has a nice look.


### Monitoring and Logging Services

#### Grafana
I have a single grafana instance here, though it pulls data from various places on the network.   Some  of the information it displays:
- Network stats from [Unifi Poller](https://github.com/unifi-poller/unifi-poller)
- SNMP data from the DS720+

#### Unifi-Poller, Telegraf

Used to collect metrics and health data from the Unifi controller, SNMP and other points requiring a central
collection agent.


#### InfluxDB

InfluxDB has the potential to be a bit of a memory hog depending on how much you feed it so I opted to move it to the
NUC. It is not the end of the world if its data is lost since most of it is deleted after 7 days anyway. Currently I
am collecting the stats from unifi-poller and telegraf here. The Grafana instance above connects to this InfluxDB to
create various dashboards.

#### Graylog
I like Graylog because it is very powerful and fast to get up and running. It also can consume quite a bit of CPU and
memory if you aren't careful. I have all of my Unifi devices, the DS720+ and the NUC sending their syslog messages to
this instance where I am able to parse the logs and create notifications for certain events.

#### Netdata
Netdata is a system monitoring tool that has unmatched auto-discovery abilities. However, it favors real-time
monitoring so I use its API to collect historic data, which is then used by Grafana to create dashboards.

### Development Services

#### Gitbucket
Gitbucket is API-compatible (mostly) with Github, which I also use, so most of the automation and tools I create will
work with both services. It also supports gists, which I use heavily in my local environment.
Gitea is a bit more lightweight but the extra features provided by Gitbucket and its plugins are worth the extra oomph
required to run it to me.

### Identity Management Services

#### LDAP Server
Having an LDAP server, even for a home network, makes managing log-ins and (auto) mounting file shares much easier.

#### 1Password Connect API
I am a long-time user of 1Password. I use the Connect API for centralized secret managements throughout my network.
Along with LDAP, this is another service that greatly simplifies configuring and deploying new resources for development or production environments.

---

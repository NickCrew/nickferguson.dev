{
    "title": "Homelab Tour",
    "date": "2021-06-01"
}


An overview of my home network, lab and development environment.

---

### Gear

#### Network

As part of an ancient quest to spend less time maintaining a more reliable home network, I went all-in on Unifi this year. I am not a total stranger to Ubiquiti; previously I was using an Edgerouter X, however I also upgraded my internet to a symmetric gigabit connection and that was more than the poor little ER-X could handle.  

Despite many a tale of woe on Reddit and the Internet, I chose to start with an Unifi Dream Machine Pro (UDMP) and I'm glad I did because it has been solid for me and while the EdgeOS has more raw capabilities, I found the UDMP to do everything I needed and without extensive configuring.

The full Unifi setup includes: 
- __Dream Machine Pro__ (UDMP)
- __USW-16-PoE__ (gigabit switch with 2x SFP)
- __U6-Lite__ (Wifi 6 access point)
- __UAP-AC-Lite__ (Wifi 5 access point)

#### Storage

I have a __Synology DS720+__ that enjoys 'appliance' status on the network. In addition to normal storage, production services with stricter availability requirements run on this device in Dcker containers.

#### Compute

For production services with higher memory or CPU requirements, I am using a __NUC8i3BEH__ with 16GB memory and 2 256GB SSDs in RAID-1.

### Availability Levels

I tend to use loose tiered model to categorize the services on my home network and this usually determines host(s) it
on and how it is deployed.  
1. __Production__ - *Critical* __:__ If these services go down the entire network is broken.
2. __Production__ - *Normal* __:__ Apps used daily in the household. _(e.g.Entertainment and media organization)_
3. __Development__ - *Lab* __:__ Experimental projects and services. Usually not backed up.
4. __Special__ - *Monitoring* __:__ Metric and log collection for production devices and services. Sometimes used to monitor development services.





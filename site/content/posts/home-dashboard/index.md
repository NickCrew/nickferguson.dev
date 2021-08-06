+++
author = "Nick Ferguson"
title = "Household Services Dashboard"
date = "2021-07-30T20:25:19-04:00"
summary = "This post shows off the [Homer](https://github.com/bastienwirtz/homer) dashboard project along with a demo of my instance."
tags = ["docker","home lab","web"]
categories = ["Home Automation"]
+++

## The first step is admitting you have a problem

Some of you may be like me (you have my sympathies) and get your kicks out of a dangerously over-engineered home network. All the frustation of things 'not worth automating' at your job might erupt here and pretty soon you have the smartest light-bulb on the planet - that's stuck on because switches are so last century.  

You may even provide immense value (downtime?) to your family with fancy Plex servers and auto-requesters.  

But how do you _enter_ this magic LANd? (get it? heh.) And more importantly, how do you enshrine your awesome network in a single picture you can show off on the internet? Yes. You need a portal. A portal through which you enter into a world where intellectual property and the MPAA are held in the highest esteem. 

There's only one problem. You already spend 27 hours a week propping up and patching your impressive _self-hosted infrastructure_. You fear the addition of yet another parasitic web app that you know you cannot nourish without losing your you know what (no not your girlfriend, ha, as if. no we're talking about your job.) So you want something simple. Dead-simple. So simple you wonder if it will adequately stroke your massive ego enough to justify its existence.  

Enter [Homer](https://github.com/bastienwirtz/homer) (The Classical Greek author who invented sprinkle donuts for the undeducated amongst you.)

## Homer

Homer is a sick-as-heck dashboard configured with a single YAML file (Hey! You _love_ YAML!).  
And yes you can run it in a Docker container.  

This is my cool dashboard inspired by an image I often conjure when thinking of my own home: a dumpster, set ablaze on the beach, flames lapping at the palms overhead.

{{< resize-image src="homer1.png" alt="Homer Screenshot" caption="My Home Dashboard" >}}

You might think from the user-friendly names I've given things that this thing is a true _home_  portal with multiple users.  

But you would be wrong.  

'Tis only I. After all, it took 400 hours to teach my mom how to use the AppleTV's double-click-invoked app switcher.


{{< resize-image src="homer2.png" alt="Homer Screenshot" caption="My Home Dashboard" >}}

Check out [Homer](https://github.com/bastienwirtz/homer).

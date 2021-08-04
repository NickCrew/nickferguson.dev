+++
author = "Nick Ferguson"
title = "Fancy Git Log"
date = "2021-08-04T01:22:15-04:00"
description = "Use Git aliases to create the fanciest of git logs"
tags = ["git","linux","programming"]
categories = ["Tutorial"]
+++

At least two things are true of programmers: they have the memory of a gold fish and instead put all of their energy into minimizing the time it takes to look-up or invoke the same crap 5000 times and they love showing off sick, colorful terminal output.

Let's combine the twisted incantations used to invoke beautiful git logs with the git `alias` configuration.

--- 

## Street (nerd) Cred

The git log is awesome. It shows you all the terrible mistakes and feverish attempts to correct them throughout the life of a project.   

 
{{< resize-image src="log_cap.png" alt="Git Log Output" caption="Git Log Output" >}}

It's pretty nice on its own with a simple `git log` but lets be real, you cannot let this obviously stock output print to your terminal or everyone will know what a noob you are.  

## Who Needs Money or Sweet Car

... When you can do this

{{< resize-image src="lg2_cap.png" alt="Fancy Git Log Output" caption="Fancy Git Log w/ Branch Graph" >}}

This is what you wanted the git log to look like you just had no way of conceptualizing it. Like a fish in the ocean that knew they were sick of getting chased by dolphins but had no idea what a tree is.  

The graph on the left maps branching so you can easily see the merge history. The commit hash is reduced to a size we actually need and the time is displayed in a way my over-caffeinated brain can actually do something useful with.  


But maybe you're going to squash and re-base everyone's commits and force push it back on the remote. You can ditch that branch graph and get a more concise view like so: 

{{< resize-image src="lg1_cap.png" alt="Concise (but still fancy) Git Log" caption="Concise (but still fancy) Git Log" >}}

## But How?

Check out my udemy course for just $9.99 -- __just kidding__.  

The answer is git aliases. Git aliases can be defined within any config scope, but here we'll just do the global because honestly, where would you _not_ want these bitchin' logs.  

Launch VS Code and go have a coffee while it starts or gather what dignity you haven't sacrificed to the electron apps in exchange for more memory and open `~/.gitconfig` in `vim`.  

````bash
# ~/.gitconfig

[alias]
    lg1 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
    lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all
````

Change `lg1` and `lg2` to whatever you want since I know you have a way more creative and informative descriptor than 1 and 2 (enjoy it while it lasts).  

## Low-Effort Dump

Here are the other kick-ass git aliases I'm using

````bash
# ~/.gitconfig

[alias]
     l = log --pretty=oneline -n 5
     ci = commit
     pu = push
     pl = pull
     fe = fetch
     co = checkout
     cob = checkout -b
     undo = reset HEAD~1 --mixed
     amend = git commit -a --amend
     unstage = reset HEAD --
     last = log -1 HEAD
     st = status
     cm = !git add -A && git commit -m
     up = !git pull --rebase --prune $@ && git submodule update --init --recursive
     wipe = !git add -A && git commit -qm  WIPE SAVEPOINT  && git reset HEAD~1 --hard
     p4 = !git-p4.py
     root = rev-parse --show-toplevel
     lch = log -n 1 --pretty=format:'%H'
````

## Disclaimer and Credit

I shamelessly stole or adapted almost everything here from some other nerds at various times. If I could give a better attribution than that I would. 


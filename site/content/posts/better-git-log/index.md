+++
author = "Nick Ferguson"
title = "Look cool with these sick Git configs"
date = "2021-08-04T01:22:15-04:00"
description = "Use Git aliases to create the fanciest of git logs"
tags = ["git","linux","programming"]
categories = ["Tutorials"]
+++

At least two things are true of programmers: they have the memory of a gold fish and instead put all of their energy into minimizing the time it takes to look-up or invoke the same crap 5000 times and they love showing off sick, colorful terminal output.

Let's combine the twisted incantations used to invoke beautiful git logs with the git `alias` configuration.

--- 


## Fancy Log 

The git log is awesome. It shows you all the terrible mistakes and feverish attempts to correct them throughout the life of a project.   

 
{{< resize-image src="log_cap.png" alt="Git Log Output" caption="Git Log Output" >}}

It's pretty nice on its own with a simple `git log` but lets be real, you cannot let this obviously stock output print to your terminal or everyone will know what a noob you are.  


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

## Aliases

Here are the other kick-ass git aliases I'm using

````bash
# vim: ft=gitconfig
# ~/.config/git/alias

[alias]
	a = add
	st = status -sb
	fresh = !"git clean -x -d -f"

	# Worktrees
	wt = worktree
	lswt = worktree list
	mkwt = "!f() { git worktree add \"$(git rev-parse --show-toplevel)+$@\"; }; f"
	rmwt = "!f() { git worktree remove \"$(git rev-parse --show-toplevel)+$@\"; }; f"

	# Commits
	c = commit
	ca = commit -a
	cm = commit -m
	cam = commit -am

	# Branches
	pu = push                           
	pl = pull                           
	fe = fetch                          
	co = checkout                       
	cob = checkout -b					

	# Diff and Merge
	cp = cherry-pick
	mmm = !git fetch origin master && git merge origin/master --no-edit
	d = diff
	dt = difftool
	dtg = !"git difftool -g"
	dtlast = !"git difftool HEAD@{1}"

	# Work-in-progress
	wip = !git add -A && git commit -m 'WIP'

	# Drop current changes
	drop = !git stash && git stash drop

	# revert last commit
	undo = reset HEAD~1 --mixed  		

	# revert added files 
	unstage = reset HEAD --      		
	ua = reset HEAD

	# revert all modifications
	rev = reset HEAD~1 --hard        

	# add and commit all changed files
	cm = !git add -A && git commit -m   

	# Update including submodules
	up = !git pull --rebase --prune $@ && git submodule update --init --recursive  

	# Total obliteration
	wipe = !git add -A && git commit -qm  WIPE SAVEPOINT  && git reset HEAD~1 --hard

	# Compact and readable log
	l = log --graph --pretty=format:'%C(magenta)%h%C(blue)%d%Creset %s %C(blue bold)- %an, %ar%Creset'

	# Log with list of changed files for each commit
	ll = log --stat --abbrev-commit

	# List of my own commits
	my = !git log --branches=* --no-merges --pretty=format:'%C(reset)%C(bold)%cd %C(reset)%C(white)%s  %C(reset)%h' --date=short --author=\"$(git config user.name)\"

	# pick a default log style
	lg = log --graph --decorate --oneline --abbrev-commit

	# List of branches ordered by last change
	branches = for-each-ref --sort=-committerdate refs/heads/ --format='%(color:bold)%(refname:short)%(color:reset)\t%(committerdate:relative)'

	# show last commit in directory
	slc = !"git show $(git lcd)"  

	# Last modified by
	lum = log -s -n1 --pretty='format:%an %ae%n'

	# List of files with merge conflicts
	wtf = diff --name-only --diff-filter=U

	# Rebase: add changes and continue
	cont = !git add . && git rebase --continue

	# Rebase: skip a rebase step
	skip = rebase --skip

	# Rebase: abort
	abort = rebase --abort

	# Cancel local commits in the branch: git fuck master
	fuck = "!f() { git reset --hard origin/$1; }; f"	


````

_I shamelessly stole or adapted almost everything here from some other nerds at various times. If I could give a better attribution than that I would._


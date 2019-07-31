# Template for Confidential Dotfiles
I wrote it originally in my private repository, but I'm open it redacting some parts. I want to share how I'm doing since I saw some folks asking or excited about that idea. So, for the next sections, ignore the `NOT SHARE`, but if you fork it in private, keep as an alert. Anyways, it is just suggestions, get whatever you like as an example.

Suggestions for private repo:
* Your clients enterprise solution. It can be even a subversion/mercury/etc.
* Gitlab and Bitbucket give you private repos for free.
* Some other sync solution like dropbox or gdriver.

> Please, adapt the files to your own. Do not share secrets, even in the private repos. Use it also to avoid client name exposure in your public dotfiles. Another solution is to put the entire dotfiles in a private channel. Sorry for the redundancy XD

-----------

# Confidential Alan Dotfiles

This repository is for personal usage and should be private and not shared. 
If for some reason you get access to it, please do NOT SHARE for public. 
You can refer to this or even fork, but make sure to keep it private too.

## How it works

It will work as a submodule on my public dotfiles, following a tied struct:

```bash
# if already configured
git clone --recurse-submodules git@github.com:voiski/dotfiles.git ~/.dotfile

# if you wanna configured it first time
git clone git@github.com:voiski/dotfiles.git ~/.dotfile
cd ~/.dotfile
git submodule add git@gitlab.com:voiski/dotfilesconfidential.git dotfilesconfidential
git commit -m 'Adding confidential module'
git push
```

## Content

It has my work aliases and functions, and I also keep a github config with
custom attributes. It is sensitive data, or just make reference to the client
that I work and I keep it hidden from the public due a secrecy agreement.
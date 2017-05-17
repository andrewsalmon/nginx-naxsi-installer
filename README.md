# Nginx + Naxsi Installer

Hi there and thank you for checking out my Nginx + Naxsi Installer. I'm happy to provide you with the following information about my script. I hope I am able to benefit you in some way :)

# Why did you write this script?
There are loads of tutorials online for installing Nginx with Naxsi however many of them are lacking in various information or use outdated source code links among other various issues. It also takes a lot of time to do this by hand so I decided to automate the process. I mainly wrote this script for my personal use however I've decided it may benefit many others who might be confused about a specific step of the process and decided to put this in a public rather than private GitHub repo.

## What does this script do?
This script fetches the source code from the applicable sources, compiles it, and then installs it with a user-friendly init.d script for automatically starting the script as well as providing service commands. The script also has sane default configs so you don't need to adjust a ton of stuff before starting to use the server :)

## Will this script be maintained?
I use this script to setup my production systems so I have a vested interest in maintaining it and keeping the source code up to date. As always you should always check the source code links and make sure they are the right source for you if you'd like to use a different version just make the appropriate adjustments to this script and then run as usual.

##  License?
This software is released under the 'Unlicense' you may view the license file at https://github.com/nsuchy/nginx-naxsi-installer/blob/master/LICENSE

## Disclaimer:
This script was written with a fresh Ubuntu Server 16.04 LTS system in mind. This will upgrade all packages at startup. I am not responsible if you install this on an existing system and end of breaking something. Consider yourself warned.

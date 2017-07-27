# Nginx + Naxsi Installer

Hi there and thank you for checking out my Nginx + Naxsi Installer. I'm happy to provide you with the following information about my script. I hope I am able to benefit you in some way :)

## Why did you write this script?
There are loads of tutorials online for installing Nginx with Naxsi however many of them are lacking in various information or use outdated source code links among other various issues. It also takes a lot of time to do this by hand so I decided to automate the process. I mainly wrote this script for my personal use however I've decided it may benefit many others who might be confused about a specific step of the process and decided to put this in a public rather than private GitHub repo.

## What does this script do?
This script fetches the source code from the applicable sources, compiles it, and then installs it with a user-friendly init.d script for automatically starting the script as well as providing service commands. The script also has sane default configs so you don't need to adjust a ton of stuff before starting to use the server :)

## Is Lua Supported?
I added support for Lua on Saturday May 20th, 2017 if you aren't sure when you ran this script run "nginx -V" in your terminal and check to see if the output looks like:

    root@lunorian-nginx:~# nginx -V
    nginx version: nginx/1.12.0
    built by gcc 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.4) 
    built with OpenSSL 1.0.2g  1 Mar 2016
    TLS SNI support enabled
    configure arguments: --conf-path=/usr/local/nginx/conf/nginx.conf --add-module=/usr/local/naxsi-0.55.3/naxsi_src/ --error-log-path=/usr/local/nginx/logs/error.log --http-client-body-temp-path=/usr/local/nginx/body --http-fastcgi-temp-path=/usr/local/nginx/fastcgi --http-uwsgi-temp-path=/usr/local/nginx/uwsgi --http-scgi-temp-path=/usr/local/nginx/scgi --http-log-path=/usr/local/nginx/logs/access.log --http-proxy-temp-path=/usr/local/nginx/proxy --lock-path=/var/run/nginx.lock --pid-path=/var/run/nginx.pid --with-http_ssl_module --with-http_ssl_module --with-http_addition_module --with-http_realip_module --with-http_gunzip_module --without-mail_pop3_module --without-mail_smtp_module --without-mail_imap_module --without-http_uwsgi_module --without-http_scgi_module --with-ipv6 --sbin-path=/usr/sbin/nginx --prefix=/usr/local/nginx --with-ld-opt=-Wl,-rpath,/usr/local/bin/luajit-2.0.5 --add-module=/usr/local/ngx_devel_kit-0.3.0 --add-module=/usr/local/lua-nginx-module-0.10.9rc5

## Will this script be maintained?
I use this script to setup my production systems so I have a vested interest in maintaining it and keeping the source code up to date. As always you should always check the source code links and make sure they are the right source for you if you'd like to use a different version just make the appropriate adjustments to this script and then run as usual.

## I want in how do I install?
It's easy just run the following commands in your terminal over SSH (I would make sure you have between 10 and 15 minutes of time to let everything run)

    wget https://raw.githubusercontent.com/nsuchy/nginx-naxsi-installer/master/setup.sh
    sudo sh ./setup.sh

## Like my work?
[<img src="https://az743702.vo.msecnd.net/cdn/kofi2.png?v=0">](https://ko-fi.com/A0532XND)

## Contributors
* @Broatcast of GitHub provided advice and helped improve the init.d script squashing the remaining bugs.

##  License?
This software is released under the 'Unlicense' you may view the license file at https://github.com/nsuchy/nginx-naxsi-installer/blob/master/LICENSE

## Disclaimer:
This script was written with a fresh Ubuntu Server 16.04 LTS system in mind. This will upgrade all packages at startup. I am not responsible if you install this on an existing system and end of breaking something. Consider yourself warned.

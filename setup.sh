##
# Nginx & Naxsi Installer
# This script installs Nginx & Naxsi by compiling from source
# Note: This script is in a working state now. Everything is complete - naxsi runs in learning mode after the install
##

# Get nginx source
wget http://nginx.org/download/nginx-1.12.0.tar.gz

# Extract nginx source
tar -xvzf nginx-1.12.0.tar.gz
rm nginx-1.12.0.tar.gz

# Get naxsi source
wget https://github.com/nbs-system/naxsi/archive/0.55.3.tar.gz
tar -xvzf 0.55.3.tar.gz
rm 0.55.3.tar.gz

# Get LuaJIT 2.0.5
wget http://luajit.org/download/LuaJIT-2.0.5.tar.gz
tar -xvzf LuaJIT-2.0.5.tar.gz
rm LuaJIT-2.0.5.tar.gz

# Get lua module source
wget https://github.com/openresty/lua-nginx-module/archive/v0.10.9rc5.tar.gz
tar -xvzf v0.10.9rc5.tar.gz
rm v0.10.9rc5.tar.gz

# Get nginx devel kit
wget https://github.com/simpl/ngx_devel_kit/archive/v0.3.0.tar.gz
tar -xvzf v0.3.0.tar.gz
rm v0.3.0.tar.gz

# Make sure there isn't a preexisting nginx directory and creates nginx directory
rm -rf /usr/local/nginx
mkdir /usr/local/nginx/

# Move naxsi to correct location
mv naxsi-0.55.3/  /usr/local/naxsi-0.55.3/

# Move nginx devel kit to correct location
mv ngx_devel_kit-0.3.0/ /usr/local/ngx_devel_kit-0.3.0/

# move lua module to correct location
mv lua-nginx-module-0.10.9rc5/ /usr/local/lua-nginx-module-0.10.9rc5/

# Make sure system is up to date
apt -y update
apt -y upgrade
apt -y dist-upgrade

# Install dependencies
apt-get -y install build-essential make gcc
apt-get -y build-dep nginx

# Change into LUAJIT Directory
cd LuaJIT-2.0.5
make
make install
cd ..

# Change into nginx directory
cd nginx-1.12.0

# Lanch the configuration process
./configure --conf-path=/usr/local/nginx/conf/nginx.conf \
--add-module=/usr/local/naxsi-0.55.3/naxsi_src/ \
--error-log-path=/usr/local/nginx/logs/error.log \
--http-client-body-temp-path=/usr/local/nginx/body \
--http-fastcgi-temp-path=/usr/local/nginx/fastcgi \
--http-uwsgi-temp-path=/usr/local/nginx/uwsgi \
--http-scgi-temp-path=/usr/local/nginx/scgi \
--http-log-path=/usr/local/nginx/logs/access.log \
--http-proxy-temp-path=/usr/local/nginx/proxy \
--lock-path=/var/run/nginx.lock \
--pid-path=/var/run/nginx.pid \
--with-http_ssl_module \
--with-http_ssl_module \
--with-http_addition_module \
--with-http_realip_module \
--with-http_gunzip_module \
--without-mail_pop3_module \
--without-mail_smtp_module \
--without-mail_imap_module \
--without-http_uwsgi_module \
--without-http_scgi_module \
--with-ipv6 \
--sbin-path=/usr/sbin/nginx \
--prefix=/usr/local/nginx \
--with-ld-opt="-Wl,-rpath,/usr/local/bin/luajit-2.0.5" \
--add-module=/usr/local/ngx_devel_kit-0.3.0 \
--add-module=/usr/local/lua-nginx-module-0.10.9rc5

# Compile it
make

# Install it
make install

# Add nginx user
adduser --system --no-create-home --disabled-login --disabled-password --group nginx

# Create log directories and default log files
mkdir /usr/local/nginx/logs/
touch /usr/local/nginx/logs/access.log
touch /usr/local/nginx/logs/error.log

# Get init.d script
wget -O /etc/init.d/nginx https://raw.githubusercontent.com/nsuchy/nginx-naxsi-installer/master/nginx-initd.sh
sudo chmod +x /etc/init.d/nginx
sudo /usr/sbin/update-rc.d -f nginx defaults

# Switches default configuration files with a sane configuration from the repo and sets up virtual hosts
mkdir /usr/local/nginx/conf/conf.d/
rm /usr/local/nginx/conf/nginx.conf
rm /usr/local/nginx/conf/conf.d/default.conf
cp /usr/local/naxsi-0.55.3/naxsi_config/naxsi_core.rules /usr/local/nginx/conf/
wget -O /usr/local/nginx/conf/nginx.conf https://raw.githubusercontent.com/nsuchy/nginx-naxsi-installer/master/configs/nginx.conf
wget -O /usr/local/nginx/conf/conf.d/default.conf https://raw.githubusercontent.com/nsuchy/nginx-naxsi-installer/master/configs/default.conf
wget -O /usr/local/nginx/conf/naxsi_custom.rules https://raw.githubusercontent.com/nsuchy/nginx-naxsi-installer/master/configs/naxsi_custom.rules

# Stops nginx if running then starts it
service nginx restart

# Reboots server
reboot

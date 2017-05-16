##
# Nginx & Naxsi Installer
# This script installs Nginx & Naxsi by compiling from source
# Note: Currently this script is incomplete, it compiles and installs but the configuration of things isn't complete. I'll update this script as more time comes available. I hope for this script to do a fully automated setup including the init.d script (sudo service nginx restart) in the near future.
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

# Make sure there isn't a preexisting nginx directory and creates nginx directory
rm -rf /usr/local/nginx
mkdir /usr/local/nginx/

# Move naxsi to correct location
mv naxsi-0.55.3/  /usr/local/naxsi-0.55.3/

# Install dependencies
apt-get install build-essential libc6 libpcre3 libpcre3-dev libpcrecpp0 libssl0.9.8 libssl-dev zlib1g zlib1g-dev lsb-base openssl libssl-dev  libgeoip1 libgeoip-dev  google-perftools libgoogle-perftools-dev libperl-dev  libgd2-xpm-dev libatomic-ops-dev libxml2-dev libxslt1-dev python-dev

# Change into nginx directory
cd nginx-1.12.0

# Lanch the configuration process
./configure --conf-path=/usr/local/nginx/conf/nginx.conf \
--add-module=/usr/local/naxsi-0.55.3/naxsi_src/ \
--error-log-path=/var/log/nginx/error.log \
--http-client-body-temp-path=/usr/local/nginx/body \
--http-fastcgi-temp-path=/usr/local/nginx/fastcgi \
--http-uwsgi-temp-path=/usr/local/nginx/uwsgi \
--http-scgi-temp-path=/usr/local/nginx/scgi \
--http-log-path=/var/log/nginx/access.log \
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
--prefix=/usr/local/nginx

# Compile it
make

# Install it
make install

# Get init.d script
wget -O /etc/init.d/nginx https://raw.githubusercontent.com/nsuchy/nginx-naxsi-installer/master/nginx-initd.sh
sudo chmod +x /etc/init.d/nginx
sudo /usr/sbin/update-rc.d -f nginx defaults

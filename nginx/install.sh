#!/bin/bash

version=1.11.1

mkdir -p /path/to
# 大小写转换第三方module
wget -c https://github.com/replay/ngx_http_lower_upper_case/archive/master.zip -O /tmp/ngx_http_lower_upper_case.zip
unzip /tmp/ngx_http_lower_upper_case.zip -d /path/to
# 打印第三方module
wget -c https://github.com/openresty/echo-nginx-module/archive/v0.59.tar.gz -O /tmp/echo-nginx-module-0.59.tar.gz
tar -zxvf /tmp/echo-nginx-module-0.59.tar.gz -C /path/to/
# pcre包 用来实现rewrite
wget -c http://downloads.sourceforge.net/project/pcre/pcre/8.35/pcre-8.35.tar.gz -O /tmp/pcre-8.35.tar.gz
tar -zxvf /tmp/pcre-8.35.tar.gz -C /usr/local/src/
cd /usr/local/src/pcre-8.35 && \
    ./configure && \
    make && make install && \
    make clean && \
    cd -

tar -zxvf nginx-$version.tar.gz -C /usr/local/
ln -s /usr/local/nginx-$version /usr/local/nginx
ln -s /usr/local/nginx/sbin/nginx /usr/sbin/nginx
mkdir -p /etc/nginx

# 进入nginx dir

cd /usr/local/nginx && \
    ./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre=/usr/local/src/pcre-8.35 --add-module=/path/to/echo-nginx-module-0.59 --add-module=/path/to/ngx_http_lower_upper_case-master --conf-path=/etc/nginx && \
    make && make install && \
    cd -


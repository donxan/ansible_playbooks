#!/bin/bash
cd /tmp/{{ my_httpd | replace('.tar.gz','') }} ;
./configure --prefix=/usr/local/apache --sysconfdir=/etc/httpd --enable-so --enable-ssl --enable-cgi --enable-rewrite --with-zlib --with-pcre --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr-util --enable-mpms-shared=all --with-mpm=event --enable-proxy --enable-proxy-http --enable-proxy-ajp --enable-proxy-balancer --enable-lbmethod-heartbeat --enable-heartbeat --enable-slotmem-shm --enable-slotmem-plain --enable-watchdog --enable-cgid \
--enable-modules=most --enable-mods-shared=most --enable-mpms-shared=all && make -j 2 && make install && ln -s /usr/local/apache /usr/local/httpd 
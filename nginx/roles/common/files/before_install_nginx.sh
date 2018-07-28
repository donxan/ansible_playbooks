#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
LANG=en_US.UTF-8
public_file=/root/public.sh
if [ ! -f $public_file ];then
wget -O $public_file http://download.bt.cn/install/public.sh -T 5;
fi
. $public_file

download_Url=$NODE_URL
run_path='/root'
cd ${run_path}
if [ ! -f '/usr/local/lib/libjemalloc.so' ]; then
        wget -O jemalloc-5.0.1.tar.bz2 ${download_Url}/src/jemalloc-5.0.1.tar.bz2
        tar -xvf jemalloc-5.0.1.tar.bz2
        cd jemalloc-5.0.1
        ./configure
        make && make install
        ldconfig
        cd ..
        rm -rf jemalloc*
fi


if [ ! -f '/usr/local/bin/lua' ];then
        yum install libtermcap-devel ncurses-devel libevent-devel readline-devel -y
        wget -c -O lua-5.3.4.tar.gz ${download_Url}/install/src/lua-5.3.4.tar.gz -T 5
        tar xvf lua-5.3.4.tar.gz
        cd lua-5.3.4
        make linux
        make install
        cd ..
        rm -rf lua-*
fi



if [ ! -d '/usr/local/include/luajit-2.0' ];then
        yum install libtermcap-devel ncurses-devel libevent-devel readline-devel -y
        wget -c -O LuaJIT-2.0.4.tar.gz ${download_Url}/install/src/LuaJIT-2.0.4.tar.gz -T 5
        tar xvf LuaJIT-2.0.4.tar.gz
        cd LuaJIT-2.0.4
        make linux
        make install
        cd ..
        rm -rf LuaJIT-*
        export LUAJIT_LIB=/usr/local/lib
        export LUAJIT_INC=/usr/local/include/luajit-2.0/
        ln -sf /usr/local/lib/libluajit-5.1.so.2 /usr/local/lib64/libluajit-5.1.so.2
        echo "/usr/local/lib" >> /etc/ld.so.conf
        ldconfig
fi

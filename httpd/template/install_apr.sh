#!/bin/bash
cd /tmp/{{ my_apr | replace('.tar.gz','') }} ;
./configure --prefix=/usr/local/apr && make && make install
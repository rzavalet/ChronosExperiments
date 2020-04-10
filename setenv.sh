#!/bin/bash

export PATH=${PATH}:${HOME}/usr/bin
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${HOME}/usr/lib:/usr/local/BerkeleyDB.6.2/lib
export CPPFLAGS="-I/usr/local/BerkeleyDB.6.2/include -I${HOME}/usr/include"
export LDFLAGS="-L/usr/local/BerkeleyDB.6.2/lib -L${HOME}/usr/lib"

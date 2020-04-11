#!/bin/bash

#---------------------------------------------------------------------------------
# Path to berkeley db installation
#---------------------------------------------------------------------------------
export BDBPATH=/usr/local/BerkeleyDB.6.2

#---------------------------------------------------------------------------------
# Add the binaries located in our home to the PATH
#---------------------------------------------------------------------------------
export PATH=${PATH}:${HOME}/usr/bin
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${HOME}/usr/lib:${BDBPATH}/lib
echo "PATH=${PATH}"
echo "LD_LIBRARY_PATH=${LD_LIBRARY_PATH}"

#---------------------------------------------------------------------------------
# Some build flags in case we need to rebuild
#---------------------------------------------------------------------------------
export CPPFLAGS="-I${BDBPATH}/include -I${HOME}/usr/include"
export LDFLAGS="-L${BDBPATH}/lib -L${HOME}/usr/lib"

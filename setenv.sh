#!/bin/bash

USERHOME=/home/ricardo
#USERHOME=${HOME}

#---------------------------------------------------------------------------------
# Path to berkeley db installation
#---------------------------------------------------------------------------------
export BDBPATH=/usr/local/BerkeleyDB.6.2
export LIBLITMUS=${USERHOME}/litmus/liblitmus

#---------------------------------------------------------------------------------
# Add the binaries located in our home to the PATH
#---------------------------------------------------------------------------------
export PATH=${PATH}:${USERHOME}/usr/bin
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${USERHOME}/usr/lib:${BDBPATH}/lib:${LIBLITMUS}
echo "PATH=${PATH}"
echo "LD_LIBRARY_PATH=${LD_LIBRARY_PATH}"

#---------------------------------------------------------------------------------
# Some build flags in case we need to rebuild
#---------------------------------------------------------------------------------
export CPPFLAGS="-I${BDBPATH}/include -I${USERHOME}/usr/include -I${LIBLITMUS}/include -I${LIBLITMUS}/arch/x86/include -I${LIBLITMUS}/arch/x86/include/uapi -I${LIBLITMUS}/arch/x86/include/generated/uapi"
export LDFLAGS="-L${BDBPATH}/lib -L${LIBLITMUS} -llitmus -L${USERHOME}/usr/lib"

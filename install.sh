#!/bin/bash

#---------------------------------------------------------------------------------
# First download Berkeley DB from the Oracle site. As of April 2020, the
# downloads are found at
# https://www.oracle.com/database/technologies/related/berkeleydb-downloads.html
# 
# The experiments where tested with BDB 6.2.38
# 
# The instalation instructions basically consists of:
# 
# 1) Untar the files
# 2) cd build_unix
# 3) ../dist/configure
# 4) make
# 5) make install
#---------------------------------------------------------------------------------
export BDBPATH=/usr/local/BerkeleyDB.6.2


#---------------------------------------------------------------------------------
# Now go ahead and clone the required repositories and build them
#---------------------------------------------------------------------------------
DIR=`pwd`
git clone https://github.com/rzavalet/StockTradingLibrary.git
if [ $? -eq 0 ]; then
  if [ -d StockTradingLibrary ]; then
    cd StockTradingLibrary
    autoreconf -vif
    if [ $? -ne 0 ]; then
      echo "Failed to autoreconf"
      exit 255
    fi

    export CPPFLAGS="-I${BDBPATH}/include"
    export LDFLAGS="-L${BDBPATH}/lib"
    ./configure --prefix=${HOME}/usr 
    if [ $? -ne 0 ]; then
      echo "Failed to configure"
      exit 255
    fi

    make && make install
    if [ $? -ne 0 ]; then
      echo "Failed to install"
      exit 255
    fi
  fi
fi

cd ${DIR}
git clone https://github.com/rzavalet/ChronosXLibrary.git
if [ $? -eq 0 ]; then
  if [ -d ChronosXLibrary ]; then
    cd ChronosXLibrary
    autoreconf -vif
    if [ $? -ne 0 ]; then
      echo "Failed to autoreconf"
      exit 255
    fi

    export CPPFLAGS="-I${BDBPATH}/include -I${HOME}/usr/include"
    export LDFLAGS="-L${BDBPATH}/lib -L${HOME}/usr/lib"
    ./configure --prefix=${HOME}/usr 
    if [ $? -ne 0 ]; then
      echo "Failed to configure"
      exit 255
    fi

    make && make install
    if [ $? -ne 0 ]; then
      echo "Failed to install"
      exit 255
    fi
  fi
fi

cd ${DIR}
git clone https://github.com/rzavalet/ChronosXServer.git
if [ $? -eq 0 ]; then
  if [ -d ChronosXServer ]; then
    cd ChronosXServer
    autoreconf -vif
    if [ $? -ne 0 ]; then
      echo "Failed to autoreconf"
      exit 255
    fi

    export CPPFLAGS="-I${BDBPATH}/include -I${HOME}/usr/include"
    export LDFLAGS="-L${BDBPATH}/lib -L${HOME}/usr/lib"
    ./configure --prefix=${HOME}/usr 
    if [ $? -ne 0 ]; then
      echo "Failed to configure"
      exit 255
    fi

    make && make install
    if [ $? -ne 0 ]; then
      echo "Failed to install"
      exit 255
    fi
  fi
fi


cd ${DIR}
git clone https://github.com/rzavalet/ChronosXClient.git
if [ $? -eq 0 ]; then
  if [ -d ChronosXClient ]; then
    cd ChronosXClient
    autoreconf -vif
    if [ $? -ne 0 ]; then
      echo "Failed to autoreconf"
      exit 255
    fi

    export CPPFLAGS="-I${BDBPATH}/include -I${HOME}/usr/include"
    export LDFLAGS="-L${BDBPATH}/lib -L${HOME}/usr/lib"
    ./configure --prefix=${HOME}/usr 
    if [ $? -ne 0 ]; then
      echo "Failed to configure"
      exit 255
    fi

    make && make install
    if [ $? -ne 0 ]; then
      echo "Failed to install"
      exit 255
    fi
  fi
fi

cd ${DIR}
#git clone https://github.com/rzavalet/ChronosExperiments.git


#---------------------------------------------------------------------------------
# Now you can set the environment by sourcing setenv.sh
#---------------------------------------------------------------------------------
echo "Do not forget to set the environment:"
echo "source setenv.sh"

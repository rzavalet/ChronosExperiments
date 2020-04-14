#!/bin/bash

ME=$(basename $0)
ROOTDIR=${HOME}/Project
BINDIR=${ROOTDIR}/ChronosXClient

STARTUPCLIENT=${BINDIR}/chronosclient

if [ $# -ne 1 ]; then
  echo "Usage:"
  echo "  ${ME} <num_threads>"
  exit 255
fi

# Mode is actually unused for the client
NUM_THREADS=$1
SERVER="127.0.0.1"
PORT=5000
PCT_VIEW_XACTS=100

OUTFILE=/tmp/client.out

. ../setenv.sh

${STARTUPCLIENT} --clients ${NUM_THREADS} --address ${SERVER} --port ${PORT} --view-transactions ${PCT_VIEW_XACTS} > ${OUTFILE} 2>&1 
#gdb --args ${STARTUPCLIENT} --clients ${NUM_THREADS} --address ${SERVER} --port ${PORT} --view-transactions ${PCT_VIEW_XACTS}

if [ $? -ne 0 ]; then
  echo "Some error ocurred while running the test. rc: $?"
fi


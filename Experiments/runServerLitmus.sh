#!/bin/bash

ME=$(basename $0)

USERHOME=/home/ricardo
#USERHOME=${HOME}

ROOTDIR=${USERHOME}/Project
BINDIR=${ROOTDIR}/ChronosXServer

STARTUPSERVER=${BINDIR}/chronosserver
if [ ! -x ${STARTUPSERVER} ]; then
  echo "Could not find binary at: ${STARTUPSERVER}"
  exit 255
fi

if [ $# -ne 1 ]; then
  echo "Usage:"
  echo "  ${ME} <num_threads>"
  echo ""
  exit 255
fi

NUM_THREADS=$1
MODE="base"
SERVER="127.0.0.1"
PORT=5000
NUM_UPDATE_THREADS=100
NUM_SERVER_THREADS=1
#NUM_SERVER_THREADS=10
#DURATION_SEC=600
#DURATION_SEC=300
DURATION_SEC=1200
XACT_SIZE=50
DELAY_BOUND_MS=400

OUTFILE=/tmp/server.out

make -C .. init

echo "Current dir: ${PWD}"
. ../setenv.sh

setsched Linux
setsched P-RES
if [ $? -ne 0 ]; then
  echo "Failed to set scheduler plugin"
  exit 255
fi

. ./create_res_table.sh

echo "Sleeping for 5 seconds before starting server..."
sleep 5;

echo "Server will run for ${DURATION_SEC} seconds..."
${STARTUPSERVER} \
  --server-mode ${MODE} \
  --num-clients ${NUM_THREADS} \
  --update-threads ${NUM_UPDATE_THREADS} \
  --server-threads ${NUM_SERVER_THREADS} \
  --experiment-duration ${DURATION_SEC} \
  --port ${PORT} \
  --xact-size ${XACT_SIZE} \
  --delay-bound ${DELAY_BOUND_MS} \
  --initial-load \
  > ${OUTFILE} 2>&1 &

#gdb --args \
#${STARTUPSERVER} \
#  --server-mode ${MODE} \
#  --num-clients ${NUM_THREADS} \
#  --update-threads ${NUM_UPDATE_THREADS} \
#  --server-threads ${NUM_SERVER_THREADS} \
#  --experiment-duration ${DURATION_SEC} \
#  --port ${PORT} \
#  --xact-size ${XACT_SIZE} \
#  --delay-bound ${DELAY_BOUND_MS} \
#  --initial-load

echo "Sleeping for 30 seconds before signaling first update thread..."
sleep 30

release_ts
if [ $? -ne 0 ]; then
  echo "Failed to release tasks"
  exit 255
fi

echo "Sleeping for 60 seconds before signaling other threads..."
sleep 60

release_ts
if [ $? -ne 0 ]; then
  echo "Failed to release tasks"
  exit 255
fi

echo "Waiting for server to finish..."
wait

echo "Done."

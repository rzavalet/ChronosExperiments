#!/bin/bash

ME=$(basename $0)
ROOTDIR=${HOME}/Personal/Thesis/Project
BINDIR=${ROOTDIR}/ChronosXServer

STARTUPSERVER=${BINDIR}/chronosserver

if [ $# -ne 2 ]; then
  echo "Usage:"
  echo "  ${ME} <num_threads> <mode>"
  echo ""
  echo "Valid modes are:"
  echo "  base"
  echo "  ac"
  echo "  aup"
  echo "  ac_aup"
  exit 255
fi

NUM_THREADS=$1
MODE=$2
SERVER="127.0.0.1"
PORT=5000
NUM_UPDATE_THREADS=10
NUM_SERVER_THREADS=1
DURATION_SEC=600
#DURATION_SEC=120
#DURATION_SEC=900
XACT_SIZE=50
DELAY_BOUND_MS=500

OUTFILE=/tmp/server.out

make -C ../ChronosExperiments init

echo "Current dir: ${PWD}"
. ../setenv.sh

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
  > ${OUTFILE} 2>&1 

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

if [ $? -ne 0 ]; then
  echo "Some error ocurred while running the test. rc: $?"
fi


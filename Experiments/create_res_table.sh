#!/bin/bash

#------------------------------------------------------
# This script creates the required reservations for the
# different tasks (threads) used by the prototype.
#------------------------------------------------------

setsched Linux
setsched P-RES


#------------------------------------------------------
# Create NUM_SLOTS reservations for the Update Threads
#------------------------------------------------------
MAJOR_CYCLE=500
NUM_SLOTS=100
SLOT_SIZE=5
CORE=0
echo "Creating reservations for update threads"
for i in $(seq 0 $((${NUM_SLOTS}-1))); do
  START=$((i * SLOT_SIZE))
  END=$((i * SLOT_SIZE + SLOT_SIZE))
  RESERVATION=$(((CORE + 1) * 1000 + i))
  printf "  Reservation: ${RESERVATION}, Slot: '[${START}, ${END})' \n"
  resctl -n ${RESERVATION} -c ${CORE} -t table-driven -m ${MAJOR_CYCLE} $(echo "[${START},${END})")
  if [ $? -ne 0 ]; then
    echo "Failed to start reservation (${CORE}, ${RESERVATION})"
    exit 255
  fi
done


#------------------------------------------------------
# Create 1 reservation for the Client threads.
# We force the preemption of the threads by assigning
# a budget and a replenishment period of the same size
#------------------------------------------------------
RESERVATION=1001
CORE=1
echo "Creating reservation for client thread"
resctl -n ${RESERVATION} -c ${CORE} -t polling-sporadic -b 50 -p 50
if [ $? -ne 0 ]; then
  echo "Failed to start reservation (${CORE}, ${RESERVATION})"
  exit 255
fi


#------------------------------------------------------
# Create 1 reservation for the process thread.
# We force the preemption of the threads by assigning
# a budget and a replenishment period of the same size
#------------------------------------------------------
RESERVATION=1001
CORE=2
echo "Creating reservation for process thread"
resctl -n ${RESERVATION} -c ${CORE} -t polling-sporadic -b 50 -p 50
if [ $? -ne 0 ]; then
  echo "Failed to start reservation (${CORE}, ${RESERVATION})"
  exit 255
fi

#------------------------------------------------------
# Create 1 reservation for the process thread.
# We force the preemption of the threads by assigning
# a budget and a replenishment period of the same size
#------------------------------------------------------
MAJOR_CYCLE=30000
RESERVATION=1001
CORE=3
echo "Creating reservation for sampling thread"
resctl -n ${RESERVATION} -c ${CORE} -t table-driven -m ${MAJOR_CYCLE} '[0, 1000)'
if [ $? -ne 0 ]; then
  echo "Failed to start reservation (${CORE}, ${RESERVATION})"
  exit 255
fi

echo "Created reservations successfully."

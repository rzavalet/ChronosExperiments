#!/bin/bas

for i in 350 300 250 200 150 100; do
  for j in base ac aup ac_aup; do
    echo ""
    echo "Running test for ${i} threads in ${j} mode...."
    echo ""

    sh ./runServer.sh ${i} ${j} &
    sleep 10

    sh ./runClient.sh ${i} &

    wait;

    cp /tmp/stats.dat /home/rzavalet/stats/${j}_${i}.csv

  done
done

#!/bin/bash
#set -x
datadir=$PWD
outputfile=$PWD/sales2.log
delay=0
while getopts "d:i:o:" opt; do
  case $opt in
    d ) # process option delay
      delay=$OPTARG
      ;;
    i ) # process option input directory
      datadir=$OPTARG
      ;;
    o ) # process option output file
      outputfile=$OPTARG
      ;;
    ? ) 
      echo "Usage: cmd [-d] [-i] [-o]"
      exit 0
      ;;
  esac
done
echo 'Setting delay (seconds) : ' $delay
echo 'Input data directory    :'$datadir
echo 'Output file             :'$outputfile
echo $(date) ":Starting movie ticket and snacks events..."
echo $(date)':using base data' > ${outputfile}
while IFS='' read -r line || [[ -n "$line" ]]; do
  echo 'Timestamp='$(date)$line >> $outputfile
  sleep $delay
done < "${datadir}/sales_base.txt"
echo $(date) ":Ending movie ticket and snacks events..."

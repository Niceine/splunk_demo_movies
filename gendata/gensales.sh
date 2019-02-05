#!/bin/bash
#set -x
if [ "$2" == "" ]; then
    datadir=$PWD
else
    datadir=$2
fi
if [ "$3" == "" ]; then
    outputfile=$PWD/sales2.log
else
    outputfile=$3
fi
if [ "$1" == "" ]; then
  delay=0
else
  delay=$1
fi
echo $(date) ":Starting movie ticket and snacks events..."
echo $(date)':using base data' > ${outputfile}
while IFS='' read -r line || [[ -n "$line" ]]; do
  echo 'Timestamp='$(date)$line >> $outputfile
  sleep $delay
done < "${datadir}/sales_base.txt"
echo $(date) ":Ending movie ticket and snacks events..."

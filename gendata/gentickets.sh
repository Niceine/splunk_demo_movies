#!/bin/bash
#set -x
if [ "$1" == "" ]; then
    datadir=$PWD
else
    datadir=$1
fi
if [ "$2" == "" ]; then
    outputfile=$PWD/sales.log
else
    outputfile=$2
fi
echo $(date) ":Starting movie ticket and snacks events..." 
echo $(date) ":Starting log..." > $outputfile
while IFS='' read -r line || [[ -n "$line" ]]; do
    pid=`echo $line | cut -d\| -f1 | sed 's/\\r//g'`
    mid=`echo $line | cut -d\| -f2 | sed 's/\\r//g'`
    sid=`echo $line | cut -d\| -f3 | sed 's/\\r//g'`
    sid2=`echo $line | cut -d\| -f4 | sed 's/\\r//g'`
    if [ "$pid" == "PID" ] 
    then
      continue
    else
      # get ccard data
      card=`grep ^${pid}\| ${datadir}/ccards.txt | sed 's/\\r//g'`
      cid=`echo $card | cut -d\| -f1 | sed 's/\\r//g'`
      cname=`echo $card | cut -d\| -f2 | sed 's/\\r//g'`
      cctype=`echo $card | cut -d\| -f3 | sed 's/\\r//g'`
      ccnbr=`echo $card | cut -d\| -f4 | sed 's/\\r//g'`
      cage=`echo $card | cut -d\| -f5 | sed 's/\\r//g'`

      # get movie data
      movie=`grep ^${mid}\| ${datadir}/movies.txt | sed 's/\\r//g'`
      #amid=`echo $movie | cut -d\| -f1 | sed 's/\\r//g'`
      mname=`echo $movie | cut -d\| -f2 | sed 's/\\r//g'`
      mrate=`echo $movie | cut -d\| -f3 | sed 's/\\r//g'`
      mprice=`echo $movie | cut -d\| -f4 | sed 's/\\r//g'`
      
      echo 'Timestamp='$(date)'|CustomerID='$cid'|CustomerName='$cname'|CCtype='$cctype'|CCNbr='$ccnbr'|CustomerAge='$cage'|MovieID='$mid'|MovieName='$mname'|MovieRating='$mrate'|Price='$mprice >> $outputfile
# $card\|$movie
      dbm=`echo $(( ( RANDOM % 2 )  + 1 ))`
      if [ "$dbm" == "2" ]
      then
        echo 'Timestamp='$(date)'|CustomerID='$cid'|CustomerName='$cname'|CCtype='$cctype'|CCNbr='$ccnbr'|CustomerAge='$cage'|MovieID='$mid'|MovieName='$mname'|MovieRating='$mrate'|Price='$mprice >> $outputfile
      fi
      snack=""
      snack2=""
      if [ "$sid" != "0" ]
      then
        snack=`grep ^${sid}\| ${datadir}/snack_prices.txt | sed 's/\\r//g'`
        sname=`echo $snack | cut -d\| -f2 | sed 's/\\r//g'`
        sprice=`echo $snack | cut -d\| -f3 | sed 's/\\r//g'`
        echo 'Timestamp='$(date)'|CustomerID='$cid'|CustomerName='$cname'|CCtype='$cctype'|CCNbr='$ccnbr'|CustomerAge='$cage'|SnackID='$sid'|SnackName='$sname'|Price='$sprice >> $outputfile
#        echo $(date) $card\|$snack
      fi
      if [ "$sid2" != "0" ]
      then
        snack2=`grep ^${sid2}\| ${datadir}/snack_prices.txt | sed 's/\\r//g'`
        sname=`echo $snack2 | cut -d\| -f2 | sed 's/\\r//g'`
        sprice=`echo $snack2 | cut -d\| -f3 | sed 's/\\r//g'`
        echo 'Timestamp='$(date)'|CustomerID='$cid'|CustomerName='$cname'|CCtype='$cctype'|CCNbr='$ccnbr'|CustomerAge='$cage'|SnackID='$sid'|SnackName='$sname'|Price='$sprice >> $outputfile
#        echo $(date) $card\|$snack2
      fi
   fi
   sleep .5
done < "${datadir}/purchases.txt"
echo $(date) ":Ending log..." >> $outputfile
echo $(date) ":Ending movie ticket and snacks events..." 


#!/usr/bin/env bash

timestamp () {
  date "+%Y%m%d-%H%M%S"
}
export BASEDIR='/home/garyg/speedtest'

if [[ -f ${BASEDIR}/config/gdrivedir ]] ; then
   export GDRIVEDIR=`cat ${BASEDIR}/config/gdrivedir`
else
   echo "$(timestamp) INFO: Unable to find config file. Using hardcoded value instead"
   export GDRIVEDIR='1uTwLvWrTYrceTpFC-Rac2nS8_sidT2XL'
fi

if [[ ! -f ${BASEDIR}/bin/speedtest.py ]] ; then
   echo "$(timestamp) ERROR: Unable to find speedtest.py"
   exit 1
fi

echo "$(timestamp) INFO: Priming the speedtest"
${BASEDIR}/bin/speedtest.py 
sleep 5
[[ ! -d ${BASEDIR}/out ]] && mkdir $BASEDIR/out
echo "$(timestamp) INFO: Calculating speed..."
${BASEDIR}/bin/speedtest.py >> ${BASEDIR}/out/speedtest.csv
echo "$(timestamp) INFO: Syncing with gdrive"
gdrive import -p ${GDRIVEDIR} speedtest/out/speedtest.csv
exit 0

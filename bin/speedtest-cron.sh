#!/usr/bin/env bash
export BASEDIR='/home/garyg/speedtest'

if [[ -f ${BASEDIR}/config/gdrivedir ]] ; then
   export GDRIVEDIR=`cat ${BASEDIR}/config/gdrivedir`
else
   echo "INFO: Unable to find config file. Using hardcoded value instead"
   export GDRIVEDIR='1uTwLvWrTYrceTpFC-Rac2nS8_sidT2XL'
fi

if [[ -f ${BASEDIR}/bin/speedtest.py ]] ; then
   [[ ! -d ${BASEDIR}/out ]] && mkdir $BASEDIR/out
   echo "INFO: Calculating speed"
   ${BASEDIR}/bin/speedtest.py >> ${BASEDIR}/out/speedtest.csv
   echo "Syncing directories with gdrive"
   /usr/local/bin/gdrive sync upload ${BASEDIR}/out ${GDRIVEDIR}
else
   echo "unable to find speedtest.py"
   exit 1
fi

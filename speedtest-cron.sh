#!/usr/bin/env bash
export BASEDIR='/home/garyg/speedtest'

if [[ -f ${BASEDIR}/.gdrivedir ]] ; then
   export GDRIVEDIR=`cat ${BASEDIR}/.gdrivedir`
else
   export GDRIVEDIR='1uTwLvWrTYrceTpFC-Rac2nS8_sidT2XL'
fi

if [[ -f ${BASEDIR}/speedtest.py ]] ; then
   ${BASEDIR}/speedtest.py >> ${BASEDIR}/speedtest.csv
   /usr/local/bin/gdrive sync upload ${BASEDIR}/speedtest.csv ${GDRIVEDIR}
fi

#!/bin/bash
#
# get SensorCommunity a specific day(s)
#
# 2018/9 ; Andreas Cz ; inital
# 2020-01-01 ; Andreas Cz ; change to SensorCommunity archive
#

#### must be set
BASEDIR="/home/cognac/projects/AirQuality/LuftdatenInfo/archive.luftdaten.info"
BASEDIR="/media/cognac/Maxtor/AirQualityData/archive.luftdaten.info"
####

if [ -z "$1" ]
  then
    echo "No argument supplied."
    echo "usage example: $0 25 [02 [2019]]"
    echo "  - for Februar 25 2019"
    exit 2
fi

DAY=$1

if [ -z "$2" ]
  then
    MONTH=`date +%m`
    echo "set month"
else
  MONTH=$2
fi

if [ -z "$3" ]
  then
    YEAR=`date +%Y`
    echo "set year"
else
  YEAR=$3
fi


echo -e "\nget data from LuftdatenInfo for ${YEAR}-${MONTH}-${DAY}*"
#wget -m -I "${YEAR}-${MONTH}-${DAY}*" https://archive.luftdaten.info/
wget -m -I "${YEAR}-${MONTH}-${DAY}*" https://archive.sensor.community/


COLLECTDATES=`ls archive.luftdaten.info | egrep '20[0-2][0-9]-[0-3][0-9]-[0-3][0-9]' `
for d in ${COLLECTDATES}; do
  echo $d
  CYEAR=`date +%Y --date="$d"`
  CMONTH=`date +%m_%h --date="$d"`
  mkdir -p "${BASEDIR}/$CYEAR/$CMONTH"
  /bin/mv -f archive.luftdaten.info/$d ${BASEDIR}/$CYEAR/$CMONTH
  xz -9 ${BASEDIR}/$CYEAR/$CMONTH/$d/*_sds* > /dev/null
  xz -9 ${BASEDIR}/$CYEAR/$CMONTH/$d/*_b* > /dev/null
  xz -9 ${BASEDIR}/$CYEAR/$CMONTH/$d/*_d* > /dev/null
  xz -9 ${BASEDIR}/$CYEAR/$CMONTH/$d/*_h* > /dev/null
  xz -9 ${BASEDIR}/$CYEAR/$CMONTH/$d/*_p* > /dev/null
  xz -9 ${BASEDIR}/$CYEAR/$CMONTH/$d/*html* > /dev/null
  xz -9 ${BASEDIR}/$CYEAR/$CMONTH/$d/*txt* > /dev/null
done


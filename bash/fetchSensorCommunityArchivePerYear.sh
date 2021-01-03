#!/bin/bash
#
# fetchSensorCommunityArchives per Year
# based on fetchLuftDatenInfoArchive-2019
#
# requires: getSensorCommunityArchive.sh
#
# 2019 ; Andreas Cz ; initial
# 

#### must be set
BASEDIR="/media/cognac/Maxtor/AirQualityData/archive.luftdaten.info"
####


if [ -z "$1" ]
  then
    YEAR="2019"
else
    YEAR=$1
fi

####
CMDDATE=`which date`
####

for month in $(seq -f "%02g" 1 12) ; do
  for day in $(seq -f "%02g" 1 31) ; do

	MYDATE=`${CMDDATE} -d "${month}/${day}/${YEAR}" 2> /dev/null `
	RET=$?
	
	if [ "$RET" == "0" ] ; then
  	  echo ${YEAR}-$month-${day}
  	  CMONTH=`date +%m_%h --date="${YEAR}-${month}-${day}"`
  	  if [ ! -d "${BASEDIR}/$YEAR/$CMONTH/${YEAR}-${month}-${day}" ] ; then 
            ./getLuftDatenInfoArchive.sh ${day} ${month} ${YEAR}
          fi
  	fi  	

  done
done

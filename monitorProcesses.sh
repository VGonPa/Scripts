# Description: Script to monitor processes in Linux
# Dependencies: To use this script you must have the "pgrep" program installed.
# Usage: sh monitorProcesses.sh [List of processes you want to monitor]

# Copyright: (C) 2010 by Víctor González Pacheco
# Author: Víctor González Pacheco <vgonzale@ing.uc3m.es>

# LICENSE:
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU Library General Public
# License as published by the Free Software Foundation; either
# version 2 of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Library General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.


#!/bin/sh

# Text colors
GREEN_TEXT="\033[32m"
RED_TEXT="\033[31m"
DEFAULT_TEXT_COLOR="\033[0m"

# Update time (in seconds)
UPDATE_TIME=2

while true
do
  clear
  echo
  ps aux | head -n 1 | awk '{ print $1, "\t\t "$2, "\t"$3, "\t"$4, "\t"$11}'
  
  for SERVICE in "$@"
  do 
 	#SERVICE_INFO=`ps aux | egrep "${SERVICE}" | grep -v grep | grep -v $0 | awk '{ print $1, "\t"$2, "\t"$3, "\t"$4, "\t"$11, $12, $13, $14, $15}'`
	#echo -e "${SERVICE_INFO}"
 	ps aux | egrep "${SERVICE}" | grep -v grep | grep -v $0 | awk '{ print $1, "\t"$2, "\t "$3, "\t "$4, "\t"$11, $12, $13, $14, $15}'
	
#	if [ ! -z "$SERVICE_INFO" ] ; then
#		for i in `echo -e $SERVICE_INFO`
#		do
#			echo -e "${SERVICE}\t${i}"
#		done
#	fi
  done

  echo

  for SERVICE in "$@"
  do
	PIDS=`ps aux | egrep "${SERVICE}" | grep -v grep | grep -v $0 | awk '{ print $2}'`
	if [ ! -z "${PIDS}" ] ; then
		for i in "${PIDS}"
		do
			echo "${SERVICE}\t.\t.\t.\t${GREEN_TEXT}OK${DEFAULT_TEXT_COLOR}"
		done
	else
		echo "${SERVICE}\t.\t.\t.\t${RED_TEXT}MISSING${DEFAULT_TEXT_COLOR}"

	fi
  done

  echo
  date
  echo
  sleep ${UPDATE_TIME}
done

exit 0

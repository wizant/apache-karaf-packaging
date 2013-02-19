#!/bin/sh

### BEGIN INIT INFO
# Provides:          karaf
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Apache Karaf
# Description:       Apache Karaf
### END INIT INFO

# System binaries
SU=/bin/su
TOUCH=/bin/touch

NAME=$( basename -- $0 )
DESC="Apache Karaf"

KARAF_ROOT=/usr/share/karaf
KARAF_USER=karaf

START_DAEMON=${KARAF_ROOT}/bin/start
STOP_DAEMON=${KARAF_ROOT}/bin/stop

LOCK_FILE=/var/run/${NAME}.lock

# Read configuration variable file if it is present
[ -r /etc/default/$NAME ] && . /etc/default/$NAME

do_start()
{
    echo "Starting ${NAME}: ${DESC}"
    
    if [ -f "${LOCK_FILE}" ];
    then
	echo "Lock file exists - ${DESC} is running already?"
	exit 1
    else
	${SU} ${KARAF_USER} -c ${START_DAEMON}
	${TOUCH} ${LOCK_FILE}
    fi
}

do_stop()
{
    echo "Stopping ${NAME}: ${DESC}"
    ${SU} ${KARAF_USER} -c ${STOP_DAEMON}
    rm -f ${LOCK_FILE}
}

do_restart()
{
    do_stop
    do_start
}

do_reload()
{
    do_stop
    do_start
}

case "$1" in

	start)
		do_start
		;;
	stop)
		do_stop
		;;
	restart)
		do_restart
		;;
	force-reload)
		do_reload
		;;
	*)
		echo "Usage: ${NAME} {start|stop|restart|reload}"
		exit 1
		;;

esac

exit 0


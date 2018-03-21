#!/bin/bash
### BEGIN INIT INFO
# Provides:          sulad
# Required-Start:    $local_fs $network $named $time $syslog
# Required-Stop:     $local_fs $network $named $time $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Description:       <DESCRIPTION>
### END INIT INFO

CONFIG_FILE="/etc/sulad.conf"
PIDFILE="/var/run/sulad.*"
cmd="sulad"

start() {
    echo 'Starting service…' >&2
    IFS=$'\n'
    for var in $(cat $CONFIG_FILE)
    do   
        sulad $var "--pid-file /var/run/sulad" &
    done
    echo 'Service started' >&2
}

stop() {
  $kill $(cat $PIDFILE)
  echo 'Service stopped' >&2
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  retart)
    stop
    start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
esac
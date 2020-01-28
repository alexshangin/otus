#!/bin/bash
set -e

if [ "$1" = 'mysqlsh' ]; then

    if [[ -z $MYSQL_HOST || -z $MYSQL_PORT || -z $MYSQL_USER || -z $MYSQL_PASSWORD ]]; then
	    echo "We require all of"
	    echo "    MYSQL_HOST"
	    echo "    MYSQL_PORT"
	    echo "    MYSQL_USER"
	    echo "    MYSQL_PASSWORD"
	    echo "to be set. Exiting."
	    exit 1
    fi
    max_tries=12
    attempt_num=0
    until (echo > "/dev/tcp/$MYSQL_HOST/$MYSQL_PORT") >/dev/null 2>&1; do
	    echo "Waiting for mysql server $MYSQL_HOST ($attempt_num/$max_tries)"
	    sleep $(( attempt_num++ ))
	    if (( attempt_num == max_tries )); then
		    exit 1
	    fi
    done
    if [ "$MYSQL_SCRIPT" ]; then
    echo "Start $MYSQL_SCRIPT"
	mysqlsh "$MYSQL_USER@$MYSQL_HOST:$MYSQL_PORT" --dbpassword="$MYSQL_PASSWORD" --sql -f "$MYSQL_SCRIPT" || true
    fi
    if [ "$MYSQLSH_SCRIPT" ]; then
    echo "Start $MYSQLSH_SCRIPT"
	mysqlsh "$MYSQL_USER@$MYSQL_HOST:$MYSQL_PORT" --dbpassword="$MYSQL_PASSWORD" -f "$MYSQLSH_SCRIPT" --log-level=DEBUG3 || true
    fi
    exit 0
fi

exec "$@"
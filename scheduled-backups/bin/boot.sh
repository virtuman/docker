#!/usr/bin/env bash

/app/bin/config.sh

if [[ "$1" = "start" ]] ; then
	exec python /app/pytasklist/pytasklist.py /tasks
else
	echo "$ /bin/sh -c $@"
	exec /bin/sh -c "$@"
fi


#!/bin/bash
CURRENT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

ORIG=$CURRENT
LIST=$(find * -prune -type d)
for i in $LIST; do
	CURRENT=$ORIG/$i
 	echo "Building $i..."
 	source $CURRENT/build.sh
done

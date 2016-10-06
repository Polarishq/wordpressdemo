#!/bin/sh

set -e

if [ $1 = "start-service" ]; then
	sed -i "s/__WORDPRESS_HOST__/${WORDPRESS_HOST}/" /tmp/blog-test-plan.jmx
	sed -i "s/__WORDPRESS_PORT__/${WORDPRESS_PORT}/" /tmp/blog-test-plan.jmx
	if [ $JMETER_OUTAGE -gt 0 ]; then
		THREADS=30
	else
		THREADS=3
	fi
	sed -i "s/__THREADS__/${THREADS}/" /tmp/blog-test-plan.jmx
	bin/jmeter -n -t /tmp/blog-test-plan.jmx
else
	"$@"
fi
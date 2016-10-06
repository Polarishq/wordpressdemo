# Mysql

[Mysql](http://dev.mysql.com/) Needs no introduction.  For this environment, MySQL serves up requests for the Apache/PHP frontend for [Wordpress](http://wordpress.org/).  For testing, we needed a Docker container that not only built us a simple MySQL environment, but also allowed us to easily create the environment simply from a `mysqldump` SQL script from another environment.  Thankfully [Tutum](https://www.tutum.co/) already figured this out for us with their [MySQL docker container](https://github.com/tutumcloud/mysql).  We load [wordpress.sql](wordpress.sql) on startup which loads our backup from another environment, which not surprisingly contains pictures of mine inserted from my personal blog.

## Configuration

This container takes three environment variables and requires DNS to be configured to consul.  In a compose file, the configuration looks like:

	mysql:
	  image: $REPO_PREFIX/mysql
	  hostname: wordpress-mysql
	  environment:
	    MYSQL_PASS: changeme
	    STARTUP_SQL: /tmp/wordpress.sql
	  logging:
	    driver: splunk
	    options: 
	      splunk-url: http://${NODE_1_IP}:8088
	      splunk-token: 00112233-4455-6677-8899-AABBCCDDEEFF
	      splunk-insecureskipverify: 'true'
	      tag: "{{.ImageName}}@{{.Name}}@{{.ID}}"
	  dns: ${CONSUL_IP}

For the environment:

|  Environment 	|   Value	|
|---	|---	|
|   MYSQL_PASS	|   What value to set the password to for this instance of MySQL	|
|   STARTUP_SQL	|   SQL file to run on first time run.  Added to the container by the Dockerfile.	|

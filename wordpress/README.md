# Wordpress

[Wordpress](http://wordpress.org/) is one of the most popular website publishing platforms in the world.  As a project, it's well over 10 years old.  It's well understood, easy to setup and configure, and it's open source.  It makes for an ideal candidate for us to grab and use for testing.  For our environment, we recorded a JMeter test script that we run to simulate real load against the system.

## Build

We modify a couple of things about Wordpress during the build process.  We derive from the stock wordpress image, and we add two plugins.  The first is root relative URLs, which overrides the default Wordpress behavior of having every URL be a full URL including hostname, so root relative URLs allows us to override that behavior and have it generate URLs which are relative.  This makes it possible to have the hostname be an IP or dynamic DNS.

Secondly, we install a statsd plugin.  The statsd plugin gathers a few internal metrics and outputs them to statsd, which we use our [statsd](../statsd) container to aggregate and output to Splunk.

## Configuration

Configuration is pretty straight forward.  We use the stock wordpress URL image configuration items to point it to MySQL and tell it how to login.

	  wordpress:
	    image: ${REPO_PREFIX}/wordpress
	    hostname: wordpress
	    ports:
	      - "8080:80"
	    environment:
	      WORDPRESS_DB_USER: admin
	      WORDPRESS_DB_PASSWORD: changeme
	      WORDPRESS_DB_HOST: vaurien-3306.service.consul
	    logging:
	      driver: splunk
	      options: 
	        splunk-url: http://${NODE_1_IP}:8088
	        splunk-token: 00112233-4455-6677-8899-AABBCCDDEEFF
	        tag: "{{.ImageName}}@{{.Name}}@{{.ID}}"
	    restart: on-failure
	    dns: ${CONSUL_IP}

For the environment:

|  Environment 	|   Value	|
|---	|---	|
|   WORDPRESS\_DB\_USER	|   Username to use to authenticate to MySQL	|
|   WORDPRESS\_DB\_PASSWORD	|   Password to use to authenticate to MySQL	|
|   WORDPRESS\_DB\_HOST	|   Hostname to use to connect to MySQL.  We use Consul DNS to determine where to connect dynamically.	|
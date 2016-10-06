# Jmeter

[Jmeter](http://jmeter.apache.org) is a well established project used for functional and load testing against web sites.  It has a simple GUI.  On your mac, if you want to build Jmeter tests, I recommend [Homebrew](http://brew.sh/):

	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew install jmeter

[Check the Jmeter docs](http://jmeter.apache.org/usermanual/) for details on how to configure Jmeter.  I have built a test plan which simulates an admin logging into our [Wordpress](../wordpress) container and running a bunch of load against the main page the URL.

## Configuration

This container takes three environment variables and requires DNS to be configured to consul.  In a compose file, the configuration looks like:

	jmeter:
	  image: $REPO_PREFIX/jmeter
	  hostname: jmeter
	  environment:
	    WORDPRESS_HOST: ${NODE_1_IP}
	    WORDPRESS_PORT: 80
	    JMETER_OUTAGE: ${JMETER_OUTAGE}
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
|   WORDPRESS_HOST	|   Set to the IP of the wordpress server.  Note this uses the outside IP so as to hit haproxy and generate load to the proxies rather than the Apache/PHP nodes directly.	|
|   WORDPRESS_PORT	|   Wordpress port.	|
|   JMETER_OUTAGE	|   Set to an environment variable that gets set by run.sh.  By default this is set to 0 unless run by `run.sh jmeter outage on`	|
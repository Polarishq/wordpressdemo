# Vaurien

[Vaurien](http://vaurien.readthedocs.org/) describes itself as "the Chaos TCP Proxy."  Think Chaos Monkey for your application.  What we need in this demo environment is a way to reliably introduce failures and use ITSI to detect them.  Vaurien gives us a way to do this at the application tier, by being a proxy between tiers of the architecture.  The setup looks like this:

	(Jmeter Loadtest) -> (Vaurien Web Proxy) -> (Wordpress Apache/PHP) -> (Vaurien Mysql Proxy) -> (Mysql) 

Vaurien has support for several protocols, of which we're using HTTP & MySQL.  Vaurien runs a webserver that will listen for REST requests with a simple JSON payload that allows us to turn on and off [various error scenarios](http://vaurien.readthedocs.org/en/1.8/behaviors.html).  In [run.sh](../run.sh) we turn on and off these scenarios.  We use [outage.sh](../utils/outage.sh) run in our `utils` container to allow for service discovery on the internal network and call the API.

## Configuration

This container is used multiple times in our environment, between Jmeter and Apache and between Apache and MySQL.  We call the web proxy simply `web`, and we allow for it to be scaled by running `run.sh scale web=<num>`.  The MySQL proxy is called vaurien, primarily because it was originally the only vaurien instance.

	vaurien:
	    image: $REPO_PREFIX/vaurien
	    hostname: vaurien-mysql
	    environment:
	      HOST: mysql.service.consul
	      BACKENDPORT: 3306
	      PROXYPORT: 3306
	      PROTO: mysql
	    expose:
	      - "3306"
	      - "8081"
	    logging:
	      driver: splunk
	      options: 
	        splunk-url: http://${NODE_1_IP}:8088
	        splunk-token: 00112233-4455-6677-8899-AABBCCDDEEFF
	        splunk-insecureskipverify: 'true'
	        tag: "{{.ImageName}}@{{.Name}}@{{.ID}}"
	    restart: on-failure
	    dns: ${CONSUL_IP}

	  web:
	    image: $REPO_PREFIX/vaurien
	    hostname: web
	    expose:
	      - "8081"
	      - "80"
	    environment:
	      HOST: wordpress.service.consul
	      BACKENDPORT: 80
	      PROXYPORT: 80
	      PROTO: http
	      SERVICE_8081_NAME: web
	      SERVICE_80_NAME: web
	    logging:
	      driver: splunk
	      options: 
	        splunk-url: http://${NODE_1_IP}:8088
	        splunk-token: 00112233-4455-6677-8899-AABBCCDDEEFF
	        splunk-insecureskipverify: 'true'
	        tag: "{{.ImageName}}@{{.Name}}@{{.ID}}"
	    restart: on-failure
	    dns: ${CONSUL_IP}

For the environment:

|  Environment 	|   Value	|
|---	|---	|
|   HOST	|   Backend host to proxy for	|
|   BACKENDPORT	|   Backend port to connect to	|
|   PROXYPORT	|   Port to listen to for connections	|
|   PROTO	|   Protocol to use when proxying	|
|   SERVICE\_8081\_NAME	|   Override the name registrator discovers for the web interface for Vaurien	|
|   SERVICE\_80\_NAME	|   Override the name registrator discovers for the listening port for Vaurien	|
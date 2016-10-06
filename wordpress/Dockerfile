FROM wordpress:latest
COPY sedscript /tmp/sedscript
RUN apt-get update \
	&& apt-get install unzip \
	&& cd /usr/src/wordpress/wp-content/plugins \
	&& curl -s -o /usr/src/wordpress/wp-content/plugins/root-relative-urls.zip https://downloads.wordpress.org/plugin/root-relative-urls.zip \
	&& curl -s -o /usr/src/wordpress/wp-content/plugins/statsd.0.1.zip https://downloads.wordpress.org/plugin/statsd.0.1.zip \
	&& cd /usr/src/wordpress/wp-content/plugins/ \
	&& unzip /usr/src/wordpress/wp-content/plugins/statsd.0.1.zip \
	&& cd /usr/src/wordpress/wp-content/plugins/ \
	&& unzip /usr/src/wordpress/wp-content/plugins/root-relative-urls.zip \
	&& sed -i -f /tmp/sedscript /usr/src/wordpress/wp-content/plugins/statsd/statsd.php \
	&& rm /tmp/sedscript \
	&& sed -i 's/\"" combined/\" %D" combined/' /etc/apache2/apache2.conf
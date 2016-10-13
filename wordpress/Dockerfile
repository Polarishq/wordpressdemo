FROM wordpress:latest
COPY sedscript /tmp/sedscript
RUN apt-get update \
	&& apt-get install unzip \
	&& cd /usr/src/wordpress/wp-content/plugins \
	&& curl -s -o /usr/src/wordpress/wp-content/plugins/root-relative-urls.zip https://downloads.wordpress.org/plugin/root-relative-urls.zip \
	&& cd /usr/src/wordpress/wp-content/plugins/ \
	&& cd /usr/src/wordpress/wp-content/plugins/ \
	&& unzip /usr/src/wordpress/wp-content/plugins/root-relative-urls.zip \
	&& sed -i 's/\"" combined/\" %D" combined/' /etc/apache2/apache2.conf
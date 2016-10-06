FROM ubuntu:latest
RUN apt-get update \
	&& apt-get install -y python2.7 python-pip python-dev build-essential \
	&& pip install vaurien \
	&& apt-get purge -y --auto-remove python-dev build-essential
ADD proxy.patch /tmp/proxy.patch
ADD http.patch /tmp/http.patch
RUN patch /usr/local/lib/python2.7/dist-packages/vaurien/proxy.py < /tmp/proxy.patch \
	&& patch /usr/local/lib/python2.7/dist-packages/vaurien/protocols/http.py < /tmp/http.patch
EXPOSE 8081
CMD /usr/local/bin/vaurien --backend $HOST:${BACKENDPORT:-80} --proxy 0.0.0.0:${PROXYPORT:-80} --protocol $PROTO --http --http-host 0.0.0.0 --http-port 8081 --behavior 100:dummy

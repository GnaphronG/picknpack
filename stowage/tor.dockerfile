FROM debian:stretch

RUN 	groupadd -r tor && \
    	useradd -r -m -g tor tor && \
	apt-get update && \ 
	apt-get install -y --no-install-recommends dirmngr gpg && \
	apt-key adv --keyserver hkp://keys.gnupg.net --recv-keys A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 && \
	echo deb http://deb.torproject.org/torproject.org stretch main > /etc/apt/sources.list.d/tor.list && \
	apt-get update && \
	apt-get install -y --no-install-recommends tor deb.torproject.org-keyring && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	echo SOCKSPort 0.0.0.0:9050 >> /etc/tor/torrc 

USER	tor:tor
EXPOSE	9050
ENTRYPOINT tor


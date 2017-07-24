FROM ubuntu:rolling

ARG	CEF_BUILD_VERSION=3.3071.1649.g98725e6_linux64

RUN 	apt-get update && \ 
	apt-get install -y --no-install-recommends dirmngr && \
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 && \
	echo deb http://repository.spotify.com stable non-free > /etc/apt/sources.list.d/spotify.list && \
	apt-get update && \
	apt-get install -y --no-install-recommends spotify-client libgl1-mesa-dri libgl1-mesa-glx alsa-utils ca-certificates curl bzip2 && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	curl -sL http://opensource.spotify.com/cefbuilds/cef_binary_${CEF_BUILD_VERSION}_minimal.tar.bz2 | \
	tar -jx cef_binary_${CEF_BUILD_VERSION}_minimal/Resources/cef_extensions.pak && \
	mv cef_binary_${CEF_BUILD_VERSION}_minimal/Resources/cef_extensions.pak /usr/share/spotify/ && \
	rm -rf cef_binary_${CEF_BUILD_VERSION}_minimal

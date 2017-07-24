FROM ubuntu:rolling

RUN 	apt-get update && \ 
	apt-get upgrade && \
	apt-get install -y --no-install-recommends dirmngr && \
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 && \
	echo deb http://repository.spotify.com stable non-free > /etc/apt/sources.list.d/spotify.list && \
	apt-get update && \
	apt-get install -y --no-install-recommends spotify-client libgl1-mesa-dri libgl1-mesa-glx alsa-utils ca-certificates curl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN	curl -O /usr/share/spotify https://github.com/AtomicGameEngine/CEF3Binaries/raw/master/Linux/Resources/cef_extensions.pak

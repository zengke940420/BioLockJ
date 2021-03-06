# suggested build command:
# name=metaphlan2_classifier
# cd ${BLJ}
# docker build -t biolockjdevteam/${name} . -f resources/docker/dockerfiles/${name}.Dockerfile 

ARG DOCKER_HUB_USER=biolockjdevteam
ARG FROM_VERSION=v1.2.9
FROM ${DOCKER_HUB_USER}/metaphlan2_classifier_dbfree:${FROM_VERSION}

#1.) Remove DB-less MetaPhlAn2
RUN cd $BIN && rm -rf strain* && \
	rm -rf [_u]* && \
	rm -rf metaphlan2.py 
	
#5.) Download MetaPhlAn2 with DB
RUN MP_URL="https://www.dropbox.com/s/ztqr8qgbo727zpn/metaphlan2.zip" && \
	mkdir -p /app && \
	cd /app && \
	wget -qO- $MP_URL | bsdtar -xf- && \
	chmod -R 777 * && \
	mv /app/metaphlan2/* $BIN && \
	rm -rf /app/*	

#6.) Cleanup
RUN	rm -rf /usr/share/*

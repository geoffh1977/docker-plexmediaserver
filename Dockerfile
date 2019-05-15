# Build Plex Media Server Container
FROM debian:jessie
LABEL maintainer="geoffh1977 <geoffh1977@gmail.com>"

# Configure Environment Variables
ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_AU.UTF-8
ENV LC_ALL C
ENV LANGUAGE en_AU.UTF-8
ENV NEW yes

# Install OS Updates And Dependencies
RUN apt-get -y update && \
    apt-get -y install curl procps locales && \
    rm -rf /etc/localtime && \
    ln -s /usr/share/zoneinfo/Australia/Melbourne /etc/localtime && \
    sed -i "s/^# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g" /etc/locale.gen && \
    sed -i "s/^# en_AU.UTF-8 UTF-8/en_AU.UTF-8 UTF-8/g" /etc/locale.gen && \
    /usr/sbin/locale-gen && \
    apt-get clean autoclean && apt-get autoremove -y && rm -rf /var/lib/{apt,dpkg,cache,log}/

# Install Plex
RUN curl -o /tmp/plexmediaserver_1.15.4.994-107756f7e.deb https://downloads.plex.tv/plex-media-server-new/1.15.4.994-107756f7e/debian/plexmediaserver_1.15.4.994-107756f7e_amd64.deb && \
    dpkg -i /tmp/plexmediaserver_1.15.4.994-107756f7e.deb && \
    rm -f /tmp/plexmediaserver_1.15.4.994-107756f7e.deb

# Add And Configure Start Scripts
COPY scripts/start.sh /usr/local/bin/start.sh
COPY scripts/start_pms.sh /usr/local/bin/start_pms.sh
RUN chmod u+x /usr/local/bin/start.sh /usr/local/bin/start_pms.sh && \ 
    sed -i 's/LC_ALL=.*$/LC_ALL="C"/g' /usr/lib/plexmediaserver/Resources/start.sh && \
    sed -i 's/LANG=.*$/LANG="en_AU.UTF-8"/g' /usr/lib/plexmediaserver/Resources/start.sh && \
    cp /usr/lib/plexmediaserver/Resources/start.sh /usr/lib/plexmediaserver/start.sh

# Set Ports And Volumes
VOLUME ["/config","/media"]
EXPOSE 32400/tcp 32469/tcp 32410/udp 32413/udp 32414/udp 1900/udp

# Configure Start Script
CMD ["/usr/local/bin/start.sh"]

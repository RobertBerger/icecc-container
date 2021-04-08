FROM debian:buster

ENV ICECC_ENABLE_SCHEDULER=0

USER root

COPY docker-scripts/icecc-run.sh /usr/local/bin/icecc-run.sh

RUN apt-get -y update && apt-get -y upgrade && \
    apt-get -y install bash icecc git

# --> rber icecream-sundae
RUN apt-get install -y g++ libcap-ng-dev libglib2.0-dev libicecc-dev liblzo2-dev libncursesw5-dev meson ninja-build
RUN mkdir -p ~/projects/icecream-sundae && \
    HERE=$(pwd) && \
    cd ~/projects/icecream-sundae && \
    git clone git://github.com/JPEWdev/icecream-sundae.git && \
    cd icecream-sundae/ && \
    mkdir builddir && \
    cd builddir/ && \
    meson .. --buildtype release && \
    ninja && \
    ninja install && \
    cd ${HERE}
# <-- rber icecream-sundae

# meaningless, since we are on host network
EXPOSE 10245 8765/TCP 8765/UDP 8766

ENTRYPOINT ["/usr/local/bin/icecc-run.sh"]

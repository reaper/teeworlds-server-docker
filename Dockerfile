FROM debian:buster-slim

WORKDIR /tmp

RUN apt-get update
RUN apt-get -y install build-essential cmake git libfreetype6-dev libsdl2-dev libpnglite-dev libwavpack-dev python3

RUN git clone https://github.com/teeworlds/teeworlds --recurse-submodules
WORKDIR /tmp/teeworlds
RUN git submodule update --init

RUN mkdir build
WORKDIR /tmp/teeworlds/build

RUN cmake .. && make install

COPY docker/entrypoint.sh /entrypoint.sh

WORKDIR /
RUN rm -rf /tmp/teeworlds

CMD ["/usr/local/bin/teeworlds_srv", "-f", "/etc/teeworlds.cfg"]
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 8303

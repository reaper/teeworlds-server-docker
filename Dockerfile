FROM debian:buster-slim AS build

RUN apt-get update
RUN apt-get -y install build-essential \
  cmake \
  git \
  libfreetype6-dev \
  libsdl2-dev \
  libpnglite-dev \
  libwavpack-dev \
  python3

WORKDIR /tmp
RUN git clone https://github.com/teeworlds/teeworlds --recurse-submodules

WORKDIR /tmp/teeworlds
RUN mkdir build

WORKDIR /tmp/teeworlds/build
RUN mkdir out
RUN cmake .. && make DESTDIR=$PWD/out install

FROM debian:buster-slim

COPY --from=build /tmp/teeworlds/build/out /
COPY entrypoint.sh /entrypoint.sh
COPY teeworlds.cfg /etc/teeworlds.cfg

CMD ["/usr/local/bin/teeworlds_srv", "-f", "/etc/teeworlds.cfg"]
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 8303

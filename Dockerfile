FROM ubuntu
LABEL maintainer "Wassim DHIF <wassimdhif@gmail.com> (https://github.com/wdhif)"

ENV STEAMCMDDIR /home/steam/steamcmd

# Update and install dependencies
RUN apt-get update
RUN apt-get install -y --no-install-recommends --no-install-suggests \
  lib32stdc++6 \
  lib32gcc1 \
  wget \
  ca-certificates
RUN apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/

# Switch to steam user
RUN useradd -m steam
USER steam

# Switch to STEAMCMDDIR directory
RUN mkdir -p ${STEAMCMDDIR}
WORKDIR $STEAMCMDDIR

# Download and extract SteamCMD
RUN wget -qO- https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar xz

VOLUME $STEAMCMDDIR

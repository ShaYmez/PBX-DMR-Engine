FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl wget build-essential git gcc-arm-linux-gnueabihf unzip libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi libncurses5-dev build-essential bison flex libssl-dev bc 

RUN apt-get install -y python

RUN cd /usr/src && git clone https://github.com/DVSwitch/md380tools.git && cd md380tools/emulator && make clean all


## Build PBX DMR Engine 
COPY --from=0 /usr/src/md380tools/emulator/md380-emu /usr/bin

RUN apt-get update && apt-get install -y wget git curl unzip gettext-base libsndfile1 libasound2

RUN [ -d /usr/local ] || mkdir -p /usr/local
RUN [ -d /opt/bridge ] || mkdir -p /opt/bridge

RUN cd /usr/local && git clone https://github.com/ShaYmez/MMDVM_Bridge.git && git clone https://github.com/ShaYmez/Analog_Bridge

RUN [ -d /opt/MMDVM_Bridge ] || mkdir -p /opt/MMDVM_Bridge
RUN [ -d /opt/Analog_Bridge ] || mkdir -p /opt/Analog_Bridge

COPY templates/MMDVM_Bridge.template /etc/MMDVM_Bridge.template
COPY templates/DVSwitch.template /etc/DVSwitch.template
COPY templates/Analog_Bridge.template /etc/Analog_Bridge.template

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y binfmt-support qemu-user
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y iproute2 python3

RUN cp /usr/local/Analog_Bridge/parrot.sh /opt/bridge
RUN cp /usr/local/Analog_Bridge/dvsm.macro /opt/bridge
RUN cp /usr/local/MMDVM_Bridge/dvswitch.sh /opt/bridge

RUN cp /usr/local/Analog_Bridge/bin/Analog_Bridge.amd64 /opt/Analog_Bridge/Analog_Bridge
RUN cp /usr/local/MMDVM_Bridge/bin/MMDVM_Bridge.amd64 /opt/MMDVM_Bridge/MMDVM_Bridge


COPY startup /startup
RUN chmod a+rx /startup

CMD [ "/startup" ]
VOLUME [ "/var/log/dmr-bridge", "/data" ]




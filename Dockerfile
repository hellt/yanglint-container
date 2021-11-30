FROM ubuntu:20.04

ARG LIBYANGVER=2.0.112

RUN apt update && apt -y install curl
RUN curl -L https://github.com/CESNET/libyang/releases/download/v${LIBYANGVER}/libyang2_${LIBYANGVER}.1-1_amd64.deb > /tmp/libyang.deb && dpkg -i /tmp/libyang.deb
RUN curl -L https://github.com/CESNET/libyang/releases/download/v${LIBYANGVER}/libyang2-tools_${LIBYANGVER}.1-1_amd64.deb > /tmp/libyang-tools.deb && dpkg -i /tmp/libyang-tools.deb

WORKDIR /work
ENTRYPOINT [ "yanglint" ]
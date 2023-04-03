FROM python:3 as builder

ARG LIBYANGVER=2.1.55

RUN pip install apkg
RUN apt update && apt -y install build-essential git
RUN git clone https://github.com/CESNET/libyang.git
WORKDIR /libyang
RUN git checkout v${LIBYANGVER} && apkg build -i

FROM ubuntu:22.04
COPY --from=builder /libyang/pkg/pkgs/debian-11/libyang2_2.1.55-1/libyang2-tools_2.1.55-1_amd64.deb /tmp
COPY --from=builder /libyang/pkg/pkgs/debian-11/libyang2_2.1.55-1/libyang2_2.1.55-1_amd64.deb /tmp
RUN dpkg -i /tmp/libyang2_2.1.55-1_amd64.deb && dpkg -i /tmp/libyang2-tools_2.1.55-1_amd64.deb
WORKDIR /work

ENTRYPOINT [ "yanglint" ]
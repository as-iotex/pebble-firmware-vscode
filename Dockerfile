FROM ubuntu:22.04 as base

WORKDIR /workdir

SHELL ["/bin/bash", "-c"]

# System dependencies
ARG arch=amd64
RUN apt-get -y update && \
    apt-get -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
        python3-pip \
        git \
        unzip \
        ninja-build  \
        gperf  \
        device-tree-compiler  \
        wget  \
        gdb && \
    apt-get -y clean && apt-get -y autoremove && \
    # Latest PIP & Python dependencies
    python3 -m pip install -U pip && \
    python3 -m pip install -U west && \
    # Later cmake versions produce an error with zephyr version v2.4.0-ncs1
    python3 -m pip install cmake==3.18.4

# Custom NRF Connect SDK
WORKDIR /nrf-connect-sdk
RUN git clone -b v1.4.0 https://github.com/iotexproject/pebble-firmware-legacy.git v1.4.0
WORKDIR /nrf-connect-sdk/v1.4.0
RUN git clone -b v2.4.0-ncs1 https://github.com/nrfconnect/sdk-zephyr zephyr && \
    pip3 install -r zephyr/scripts/requirements.txt && \
    pip3 install -r nrf/scripts/requirements.txt && \
    pip3 install -r bootloader/mcuboot/scripts/requirements.txt
WORKDIR /nrf-connect-sdk
RUN source v1.4.0/zephyr/zephyr-env.sh && \
    # West update fails with a weird error because it tries to overwrite files already existent. But this is ok
    # Add exit 0 at the end so the docer image build continues even if west update returns an error code
    west update; exit 0

# Install Nordic command line tools and add nrfjprog to path (installed in /usr/local/bin by default)
# Releases: https://www.nordicsemi.com/Software-and-tools/Development-Tools/nRF-Command-Line-Tools/Download
WORKDIR /nrf-command-line-tools
RUN apt-get -y install libusb-1.0-0 && \
    wget -q https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/10-16-0/nrf-command-line-tools_10.16.0_amd64.deb && \
    dpkg -i nrf-command-line-tools_10.16.0_amd64.deb && \
    rm -rf nrf-command-line-tools_10.16.0_amd64.deb && cd .. && \
    rmdir /nrf-command-line-tools
ENV PATH="/usr/local/bin/:${PATH}"

# ARM Toolchain and add it to system path
WORKDIR /gcc-arm-toolchain
RUN wget -q --show-progress "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2?revision=05382cca-1721-44e1-ae19-1e7c3dc96118&hash=AE874AE7513FAE5077350E4E23B1AC08" && \
    tar -jxvf "gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2?revision=05382cca-1721-44e1-ae19-1e7c3dc96118&hash=AE874AE7513FAE5077350E4E23B1AC08" && \
    rm -rf "gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2?revision=05382cca-1721-44e1-ae19-1e7c3dc96118&hash=AE874AE7513FAE5077350E4E23B1AC08"
ENV PATH="/gcc-arm-toolchain/gcc-arm-none-eabi-9-2020-q2-update/bin/:${PATH}"

# Set environment variables
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV ZEPHYR_TOOLCHAIN_VARIANT gnuarmemb
ENV GNUARMEMB_TOOLCHAIN_PATH /workspaces/test/gcc-arm-none-eabi-9-2019-q4-major
ENV ZEPHYR_BASE /nrf-connect-sdk/v1.4.0/zephyr
 
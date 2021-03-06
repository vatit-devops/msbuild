FROM ubuntu:16.04
MAINTAINER Harry Lee <harryl@vatit.com>

# Fixes apt-get warnings
ENV DEBIAN_FRONTEND noninteractive

# Setup Mono repository
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb http://download.mono-project.com/repo/ubuntu xenial main" | tee /etc/apt/sources.list.d/mono-official.list

# Run a quick apt-get update/upgrade
RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get autoremove -y

RUN apt-get install -y locales

# Setup the locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install dependencies
RUN apt-get install -y \
    ca-certificates \
    software-properties-common \
    python-software-properties \
    mono-complete \
    wget \
    nuget \
    python-pip \
    git-core
    # mono-xsp4 \ # Required if we want to serve up Dragon through docker

# Create a symbolic link for msbuild.exe and msbuild
RUN ln -s /usr/bin/xbuild /usr/bin/msbuild.exe

# Cleanup
ENV DEBIAN_FRONTEND newt

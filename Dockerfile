FROM ubuntu:14.04

MAINTAINER amond "amond@amond.net"

# Install java7
RUN apt-get install -y software-properties-common && add-apt-repository -y ppa:webupd8team/java && apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

# Install Deps
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 python curl

# Install Android SDK
RUN cd /opt && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && tar xzf android-sdk.tgz && rm -f android-sdk.tgz && chown -R root.root android-sdk-linux


RUN echo yes | android update sdk --no-ui --all --filter tools,platform-tools --no-https
RUN echo yes | android update sdk --no-ui --all --filter build-tools-23.0.3,android-23 && \
    echo yes | android update sdk --no-ui --all --filter extra-android-m2repository,extra-google-m2repository

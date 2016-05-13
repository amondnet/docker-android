FROM lwieske/java-8:jdk-8u92-slim
MAINTAINER amond "amond@amond.net"

# Sets language to UTF8 : this works in pretty much all cases
#ENV LANG en_US.UTF-8
#RUN locale-gen $LANG

ENV ANDROID_SDK_ZIP http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools


RUN apk add --no-cache curl bash && \
    mkdir -p /opt && cd /opt && \
    wget -q ${ANDROID_SDK_ZIP} && \
    tar zxvf android-sdk_r24.4.1-linux.tgz && \
    rm android-sdk_r24.4.1-linux.tgz && \
    echo yes | android update sdk --no-ui --all --filter tools,platform-tools --no-https
    #apk add --nocache lib32stdc++6 lib32z1 && \ # FIXME

RUN echo yes | android update sdk --no-ui --all --filter build-tools-23.0.3,android-23 && \
    echo yes | android update sdk --no-ui --all --filter extra-android-m2repository,extra-google-m2repository

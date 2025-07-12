FROM gitpod/workspace-full

# Install Java 17
RUN sudo apt-get update && \
    sudo apt-get install -y openjdk-17-jdk

# Install Android SDK
ENV ANDROID_HOME /home/gitpod/android-sdk
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools/latest && \
    cd ${ANDROID_HOME}/cmdline-tools && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip && \
    unzip commandlinetools-linux-*.zip && \
    mv cmdline-tools latest && \
    rm commandlinetools-linux-*.zip

# Accept licenses and install packages
RUN yes | ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager --licenses && \
    ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"

# Add to PATH
ENV PATH ${PATH}:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/cmdline-tools/latest/bin
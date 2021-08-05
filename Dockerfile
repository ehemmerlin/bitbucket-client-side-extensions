FROM ubuntu:18.04

ARG MAVEN_VERSION=3.8.1

RUN apt update && \
    apt install -y nano git curl wget gnupg && \
    mkdir -p /usr/share/maven && \
    curl -fsSL -o /tmp/apache-maven.tar.gz https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 && \
    rm -f /tmp/apache-maven.tar.gz && \
    ln -s /usr/share/maven/bin/mvn /usr/bin/mvn && \
    wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install 12.19.0 && \
    apt install -y openjdk-8-jdk && \
    echo "deb https://packages.atlassian.com/debian/atlassian-sdk-deb/ stable contrib" >>/etc/apt/sources.list && \
    wget https://packages.atlassian.com/api/gpg/key/public && \
    apt-key add public && \
    apt update && \
    apt install -y atlassian-plugin-sdk && \
    rm -rf /var/lib/apt/lists/*

ENV MAVEN_HOME /usr/share/maven
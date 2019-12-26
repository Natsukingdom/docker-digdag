FROM openjdk:8u191-jre-alpine

ENV DIGDAG_VERSION 0.9.38
WORKDIR /src

RUN apk add --no-cache \
      bash \
      curl \
      g++ \
      gcc \
      git \
      glib-dev \
      make \
      openssh \
      py-pip \
      python \
      python-dev \
      ruby \
      ruby-bundler \
      ruby-dev \
      ruby-json && \
    pip install --upgrade pip && \
    pip install python-dateutil && \
    curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-${DIGDAG_VERSION}" && \
    curl -o /usr/local/bin/embulk --create-dirs -L "https://dl.embulk.org/embulk-latest.jar" && \
    chmod +x /usr/local/bin/digdag && \
    chmod +x /usr/local/bin/embulk && \
    sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd && \
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bash_profile && \
    echo 'export PS1="[\[\e[1;34m\]\u\[\e[00m\]@\[\e[0;32m\]\h\[\e[00m\] \[\e[1;34m\]\W\[\e[00m\]]$ "' >> ~/.bashrc

ENTRYPOINT ["java", "-jar", "/usr/local/bin/digdag"]

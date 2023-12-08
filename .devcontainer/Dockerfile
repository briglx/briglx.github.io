# FROM jekyll/jekyll:3.6 AS builder
# WORKDIR /build
# COPY Gemfile /build
# COPY Gemfile.lock /build
# COPY _config.yml /build
# RUN chown -R jekyll:jekyll /build && jekyll build
# COPY . /build

# RUN jekyll build

ARG RUBY_VERSION=2.7.4
FROM ruby:$RUBY_VERSION-slim as jekyll

RUN apt-get update && apt-get install -y \
  curl && \
  curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  apt-get install -y \
  build-essential \
  curl \
  git \
  libbz2-dev \
  libffi-dev \
  libgdbm-dev \
  libncurses5-dev \
  libnss3-dev \
  libreadline-dev \
  libsqlite3-dev \
  libssl-dev \
  locales \
  nodejs \
  shellcheck \
  wget \
  zsh \
  zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

# Install Oh My Zsh
RUN chsh -s $(which zsh)
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install npm packages
WORKDIR /app
RUN npm install

# Install Gulp globally
RUN npm install -g gulp-cli

# Install python
RUN wget https://www.python.org/ftp/python/3.10.12/Python-3.10.12.tgz && tar -xf Python-3.10.*.tgz
WORKDIR /app/Python-3.10.12
RUN /app/Python-3.10.12/configure --prefix=/usr/local --enable-optimizations --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib"
RUN make -j $(nproc)
RUN make altinstall
RUN update-alternatives --install /usr/bin/python python /usr/local/bin/python3.10 1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.10 1

# # Helpful aliases
RUN echo 'alias ll='"'"'ls $LS_OPTIONS -al'"'"'' >> /etc/bash.bashrc

# Create app directory
# RUN mkdir -p /usr/src/app
WORKDIR /app
COPY source/Gemfile /app/
COPY source/Gemfile.lock /app/
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=true
RUN bundle install

RUN \
  echo "en_US UTF-8" > /etc/locale.gen && \
  locale-gen en-US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Install requirements.txt
COPY requirements.txt /app/
COPY requirements_dev.txt /app/
RUN python -m pip install -r requirements_dev.txt

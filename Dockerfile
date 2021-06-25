FROM xqdocker/ubuntu-for-ruby:1.1.1

RUN apt-get update && apt-get -y install software-properties-common
RUN add-apt-repository -y ppa:brightbox/ruby-ng
RUN apt-get update && apt-get -y install ruby1.8 ruby1.8-dev rubygems1.8

RUN echo 'gem: --no-document' > /usr/local/etc/gemrc
RUN gem update
RUN gem install bundler -v=1.3.1
RUN gem install rake -v=0.8.7

RUN apt-get -y install build-essential zlib1g zlib1g-dev libxml2 libxml2-dev \
    libxslt-dev locate curl wget git  \
    libreadline-ruby1.8 libruby1.8 \
    libapr1-dev  libssl-dev libmysqlclient15-dev mysql-server-5.5

RUN gem install -v=2.3.2 rails
RUN gem install will_paginate -v 2.3.11
RUN gem install brazilian-rails -v 1.0.0
RUN gem install mysql -v 2.8.1

ENV RAILS_ENV production
RUN mkdir /app
WORKDIR /app

COPY . ./


FROM ruby
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  default-mysql-client \
  nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle update
RUN bundle install

ENV APP_HOME /myapp
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME
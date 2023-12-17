FROM ruby:3.2.1

ARG RAILS_ROOT=/codewars-exporter

RUN apt-get update 
RUN apt install -y firefox-esr

RUN mkdir $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile.lock  ./

RUN bundle install

ADD . $RAILS_ROOT
ENV PATH=$RAILS_ROOT/bin:${PATH}



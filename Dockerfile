FROM ruby:3.2.1-alpine

ARG APP_ROOT=/codewars-exporter
ARG PACKAGES="firefox-esr make build-base"

RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $PACKAGES

RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

COPY Gemfile Gemfile.lock  ./

RUN bundle install

ADD . $APP_ROOT
ENV PATH=$APP_ROOT/bin:${PATH}

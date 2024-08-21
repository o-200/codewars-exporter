FROM ruby:3.2.1-alpine

ARG APP_ROOT=/codewars-exporter
ARG PACKAGES="make build-base bash firefox-esr xvfb dbus ttf-freefont mesa-gl"

RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

# packages
RUN apk update && apk upgrade && \
    apk add --no-cache $PACKAGES

# geckodriver
RUN wget -q https://github.com/mozilla/geckodriver/releases/download/v0.31.0/geckodriver-v0.31.0-linux64.tar.gz && \
    tar -xvzf geckodriver-v0.31.0-linux64.tar.gz && \
    mv geckodriver $APP_ROOT && \
    chmod +x $APP_ROOT/geckodriver && \
    rm geckodriver-v0.31.0-linux64.tar.gz

# ruby dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the application code
ADD . $APP_ROOT

# Set PATH
ENV PATH=$APP_ROOT/bin:${PATH}

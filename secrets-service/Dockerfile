FROM ruby:3.1.0-alpine AS base
RUN apk --upgrade add build-base vim

RUN adduser -u 1000 -s /bin/bash -h /opt/secretsservice -S secretsservice
USER secretsservice
RUN mkdir -p /opt/secretsservice/app /opt/secretsservice/.bundle
WORKDIR /opt/secretsservice/app

RUN gem install bundler -v 2.3.23 --no-doc
COPY --chown=secretsservice Gemfile Gemfile.lock ./
RUN bundle install -j 4

COPY --chown=secretsservice . .

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

FROM base AS ci

FROM base AS prod

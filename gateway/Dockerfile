FROM ruby:3.1.0-alpine AS base
RUN apk --upgrade add build-base vim

RUN adduser -u 1000 -s /bin/bash -h /opt/gateway -S gateway
USER gateway
RUN mkdir -p /opt/gateway/app /opt/gateway/.bundle
WORKDIR /opt/gateway/app

RUN gem install bundler -v 2.3.23 --no-doc
COPY --chown=gateway Gemfile Gemfile.lock ./
RUN bundle install -j 4

COPY --chown=gateway . .

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

FROM base AS ci

FROM base AS prod

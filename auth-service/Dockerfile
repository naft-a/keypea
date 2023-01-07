FROM ruby:3.1.0-alpine AS base
RUN apk --upgrade add build-base vim

RUN adduser -u 1000 -s /bin/bash -h /opt/authservice -S authservice
USER authservice
RUN mkdir -p /opt/authservice/app /opt/authservice/.bundle
WORKDIR /opt/authservice/app

RUN gem install bundler -v 2.3.23 --no-doc
COPY --chown=authservice Gemfile Gemfile.lock ./
RUN bundle install -j 4

COPY --chown=authservice . .

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

FROM base AS ci

FROM base AS prod

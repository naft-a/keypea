FROM node:19-alpine as base
RUN apk --upgrade add vim
RUN yarn global add serve

RUN adduser -u 900 -s /bin/bash -h /opt/frontend -S frontend

USER frontend
RUN mkdir -p /opt/frontend/app
WORKDIR /opt/frontend/app

COPY --chown=frontend package.json yarn.lock ./
RUN yarn install

COPY --chown=frontend . .
RUN yarn build

ENV NODE_ENV=production

CMD ["serve", "dist", "-p", "5000"]

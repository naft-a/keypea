<div style="flex: auto">
  <h1 style="float: left">Keypea</h1>
  <p align="left">
    <img alt="keypea" src="https://keypea.app/assets/pea-c10e0357.svg" width="150" style="transform: rotate(180deg)">
  </p>
  <br />
</div>

Keypea is an app that stores encrypted secrets in a database and can be seen running at [keypea.app](https://keypea.app). This is (probably) nothing more than an attempt to implement and deploy a real-life micro-service architecture in a monorepo. The app uses a bunch of different tech, but it's mostly kept simple to show what can be done with as few dependencies as possible. It is built in 4 parts:

- The authentication service `auth-service` is a `rack` application that handles user CRUD and user authentication, it requires its own `mongodb` instance to persist data.
- The secrets service `secrets-service` also a `rack` application that deals with secrets CRUD and secrets encryption/decryption, it also requires its own `mongodb` instance to persist data.
- The gateway `gateway` is a `hanami` app that handles all user requests, sessions and routes requests to the appropriate underlying service. It requires `redis` for session management.
- The web client `frontend` is a `react` app that shows pages to users.

## Pre-requisites for development
- Ruby 3.0 or greater
- Node.js v16.15.1 or greater
- Docker
- Mongodb server
- Redis server
- Bundler
- Yarn

## Running
The whole project can be run in two ways:

- `docker-compose`
- `foreman`
  - `docker run --rm --name container-redis -d redis`
  - `docker run -d --name container-mongo -p 27017:27017 -d --restart always -e MONGO_INITDB_ROOT_USERNAME=mongoadmin -e MONGO_INITDB_ROOT_PASSWORD=secret mongo`
  - Requires `gem install foreman`
  - `cd auth-service/ && bundle`
  - `cd ../secrets-service/ && bundle`
  - `cd ../gateway/ && bundle`
  - `cd ../frontend/ && yarn install`
  - `cd ../ && formean start`

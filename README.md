<h1>
  <span>Keypea <img alt="keypea" src="https://keypea.app/assets/pea-c10e0357.svg" width="50" style="transform: rotate(180deg)"></span>
</h1>

<a href="https://raw.githubusercontent.com/naft-a/keypea/main/LICENSE">
  <img src="https://img.shields.io/github/license/naft-a/keypea.svg?style=flat" alt="license status">
</a>

<a href="https://github.com/naft-a/keypea/actions">
  <img src="https://img.shields.io/github/actions/workflow/status/naft-a/keypea/gateway.yml?label=gateway%20build" alt="license status">
</a>

<a href="https://github.com/naft-a/keypea/actions">
  <img src="https://img.shields.io/github/actions/workflow/status/naft-a/keypea/auth-service.yml?label=auth%20service%20build" alt="license status">
</a>

<a href="https://github.com/naft-a/keypea/actions">
  <img src="https://img.shields.io/github/actions/workflow/status/naft-a/keypea/secrets-service.yml?label=secrets%20service%20build" alt="license status">
</a>


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
- `foreman` (for development)

### Foreman 
You'll need to go through a quick setup before we run the whole thing

1) Run `redis` container locally:
  ```
    docker run --rm --name container-redis -d redis
  ```

2) Run `mongodb` container locally:
  ```
    docker run -d --name container-mongo -p 27017:27017 -d --restart always -e MONGO_INITDB_ROOT_USERNAME=mongoadmin -e MONGO_INITDB_ROOT_PASSWORD=secret mongo
  ```

3) Install foreman: `gem install foreman`
4) Install auth service dependencies and create db indexes:
  ```
    cd auth-service/ && bundle && rake db:mongoid:create_indexes
  ```
5) Then install secrets service dependencies and create db indexes:
  ```
    cd ../secrets-service/ && bundle && rake db:mongoid:create_indexes
  ```
6) Install gateway dependencies:
  ```
    cd ../gateway/ && bundle
  ```
7) Install frontend dependencies:
  ```
    cd ../frontend/ && yarn install
  ```
8) Start foreman
  ```
    cd ../ && formean start
  ```

Visit each project's readme for more information about environment variables and defaults used within the app. You'd also need a reverse proxy such as [caddy](https://caddyserver.com/) to route local subdomains based on each port of the app.

#### Example Caddyfile
```
frontend.localhost {
	reverse_proxy localhost:9001
	tls internal
}

gateway.localhost {
	reverse_proxy localhost:5001
	tls internal
}

auth.localhost {
	reverse_proxy localhost:5002
	tls internal
}

secrets.localhost {
	reverse_proxy localhost:5003
	tls internal
}
```

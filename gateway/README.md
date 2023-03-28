# Gateway

This is a hanami app (the gateway) which is responsible for handling user requests.

## Configuration
___
All configuration of this application is carried out using environment variables. The following environment variables are supported for this application.

- `HMAC_SECRET` - the hmac secret for JWT
- `AUTH_API_HOST` - the hostname of the auth api service (default: auth.localhost)
- `AUTH_API_PORT` - the port of the auth api
- `AUTH_API_SECRET` - the secret key for the auth api
- `SECRETS_API_HOST` - the hostname of the secrets api service (default: secret)
- `SECRETS_API_PORT` - the port of the secrets api
- `SECRETS_API_SECRET` - the secret key for the secrets api
- `REDIS_URL` - the ur of the Redis container/installation (default: redis://127.0.0.1:6379/0)
- `HANAMI_ENV` - the environment to run the application in (default: development)
- `PUMA_PORT` - used to set the listening port for whichever process is being started (default: 5002)
- `PUMA_WORKERS` - the maximum number of workers to boot (default: 2)
- `PUMA_MAX_THREADS` - the maximum number of threads to allow to be used for web requests (default: 10)

## Running

1) `bundle`
2) `hanami server`

# Authentication Service

This is the rack service that deals with authentication

## Configuration
___
All configuration of this application is carried out using environment variables. The following environment variables are supported for this application.

- `MONGODB_HOST` - the hostname of the Mongodb server (default: localhost: 27017)
- `MONGODB_USER` - the username for the Mongodb server (default: auth-service)
- `MONGODB_PASSWORD` - the password for the Mongodb server (default: secret)
- `MONGODB_DATABASE` - the name of the Mongodb database (default: auth-service)
- `RACK_ENV` - the environment to run the application in (default: development)
- `PUMA_PORT` - used to set the listening port for whichever process is being started (default: 5002)
- `PUMA_WORKERS` - the maximum number of workers to boot (default: 2)
- `PUMA_THREADS` - the maximum number of threads to allow to be used for web requests (default: 10)

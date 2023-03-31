auth_service: env PUMA_PORT=5002 sh -c 'cd ./auth-service && ./bin/dev'
secrets_service: env PUMA_PORT=5003 sh -c 'cd ./secrets-service && ./bin/dev'
gateway: env PUMA_PORT=5001 sh -c 'cd ./gateway && hanami server'
frontend: env VITE_PORT=9001 sh -c 'cd ./frontend && yarn dev'

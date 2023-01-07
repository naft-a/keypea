require "mongoid"

Mongoid.configure do |config|
  config.clients.default = {
    hosts: [ENV.fetch("MONGODB_HOST", "localhost:27017")],
    database: ENV.fetch("MONGODB_DATABASE", "auth-service"),
    options: {
      user: ENV.fetch("MONGODB_USERNAME", "mongoadmin"),
      password: ENV.fetch("MONGODB_PASSWORD", "secret"),
      auth_source: "admin",
      mechanism: :scram
    }
  }
end

Mongoid.raise_not_found_error = false

unless ENV["RACK_ENV"] == "test"
  Mongoid.logger = Logger.new(STDERR).tap do |log|
    log.level = Logger::DEBUG
  end

  Mongo::Logger.logger = Mongoid.logger
end

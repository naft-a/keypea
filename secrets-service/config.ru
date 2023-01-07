# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path(__dir__))

require "apia"
require "apia/rack"
require "mongoid"

if ENV["RACK_ENV"] == "development"
  require "pry-remote"
  require "dotenv"

  Dotenv.load(".env.development")
end

require "./app"
require "./config/mongoid"
require "./lib/crypto"
require "./models/password"
require "./models/encryption_key"
require "./models/part"
require "./models/secret"
require "api/v1/base"

# Logging
AppLogger = Logger.new(STDOUT)
AppLogger.instance_eval do
  def write(msg)
    msg.sub!(/password=\S+/, "password=[FILTERED]")
    self.send(:<<, msg)
  end
end
use Rack::CommonLogger, AppLogger

# Middleware
use Apia::Rack, Api::V1::Base, "/core/v1", development: ENV["RACK_ENV"] == "development"

# Entrypoint
run SecretsService

# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path(__dir__))

require "apia"
require "bcrypt"
require "apia/rack"

if ENV["RACK_ENV"] == "development"
  require "pry-remote"
  require "dotenv"

  Dotenv.load(".env.development")
end

require "./app"
require "./config/mongoid"
require "./models/user"
require "api/v1/base"

use Rack::CommonLogger, Logger.new(STDOUT)

# Middleware
use Apia::Rack, Api::V1::Base, "/core/v1", development: ENV["RACK_ENV"] == "development"

# Entrypoint
run AuthService

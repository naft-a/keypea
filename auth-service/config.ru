# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path(__dir__))

require "apia"
require "bcrypt"
require "apia/rack"
require "mongoid"

require "./app"
require "./models/user"
require "api/v1/base"

require "pry-remote" if ENV["RACK_ENV"] == "development"

use Rack::CommonLogger, Logger.new(STDOUT)

# MongoDB
Mongoid.load!(File.join(File.dirname(__FILE__), 'mongoid.yml'))
Mongoid.raise_not_found_error = false

Mongoid.logger = Logger.new(STDERR).tap do |log|
  log.level = Logger::DEBUG if ENV["RACK_ENV"] == "development"
end
Mongo::Logger.logger = Mongoid.logger

# Middleware
use Apia::Rack, Api::V1::Base, "/core/v1", development: ENV["RACK_ENV"] == "development"

# Entrypoint
run AuthService

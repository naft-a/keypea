# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path(__dir__))

require "apia"
require "apia/rack"
require "mongoid"

require "./app"
require "./lib/crypto"
require "./models/encryption_key"
require "./models/part"
require "./models/secret"
require "api/v1/base"

require "pry-remote" if ENV["RACK_ENV"] == "development"

# ===== Rack config =====
AppLogger = Logger.new(STDOUT)
AppLogger.instance_eval do
  def write(msg)
    msg.sub!(/password=\S+/, "password=[FILTERED]")
    self.send(:<<, msg)
  end
end
use Rack::CommonLogger, AppLogger

# ===== MongoDB =====
Mongoid.load!(File.join(File.dirname(__FILE__), 'mongoid.yml'))
Mongoid.raise_not_found_error = false

Mongoid.logger = Logger.new(STDERR).tap do |log|
  log.level = Logger::DEBUG if ENV["RACK_ENV"] == "development"
end
Mongo::Logger.logger = Mongoid.logger

# ===== Middleware =====
use Apia::Rack, Api::V1::Base, "/core/v1", development: ENV["RACK_ENV"] == "development"

# ===== Entrypoint =====
run SecretsService

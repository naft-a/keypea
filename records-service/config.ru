# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path(__dir__))

require "apia"
require "apia/rack"
require "rack/cors"

require "./app"
require "api/v1/base"

require "pry-remote" if ENV["RACK_ENV"] == "development"

# ===== Rack config =====
logger = Logger.new("log/#{ENV["RACK_ENV"]}.log")
logger.instance_eval do
  def write(msg)
    msg.sub!(/password=\S+/, "password=[FILTERED]")
    self.send(:<<, msg)
  end
end

use Rack::CommonLogger, logger
use Rack::Session::Cookie, key:'rack.session', expire_after: 2592000, secret: 'TODO:'
use Rack::Cors do
  allow do
    origins 'localhost:3000', '127.0.0.1:50'
    resource '*',
             methods: [:get, :post, :delete, :put, :patch, :options, :head],
             headers: :any
  end

  # allow do
  #   origins '*'
  #   resource '/public/*', headers: :any, methods: :get
  #
  #   # Only allow a request for a specific host
  #   resource '/core/v1/*',
  #            headers: :any,
  #            methods: :get,
  #            if: proc { |env| env['HTTP_HOST'] == 'api.example.com' }
  # end
end

# ===== Middleware =====
use Apia::Rack, Api::V1::Base, "/core/v1", development: ENV["RACK_ENV"] == "development"

# ===== Entrypoint =====
run RecordService

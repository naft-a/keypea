# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path(__dir__))

require "apia"
require "apia/rack"
require "omniauth"
require "omniauth-github"
require "rack/csrf"
require "rack/cors"

require "./app"
require "api/v1/base"

require "pry-remote" if ENV["RACK_ENV"] == "development"

# ===== Rack config =====
use Rack::Session::Cookie, key:'rack.session', expire_after: 2592000, secret: 'change_me'
use Rack::Csrf
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

# ===== OAuth2 =====
use OmniAuth::Builder do
  configure do |config|
    config.path_prefix = '/core/v1/auth'
    config.request_validation_phase = false
  end

  provider :github, "b0ed6054ad7f72ab53c3", "ac73296be35e724e9187479a94fe79a10c5a42dd", callback_path: "/core/v1/auth/github/callback"
end

# ===== Middleware =====
use Apia::Rack, Api::V1::Base, "/core/v1", development: ENV["RACK_ENV"] == "development"

# ===== Entrypoint =====
run AuthService

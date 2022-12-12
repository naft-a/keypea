# frozen_string_literal: true

# require "./app"
require "apia"
require "apia/rack"
require "pry-remote"

require_relative "../api/v1/base"
require_relative "../api/v1/endpoints/list_secrets"
require_relative "../api/v1/endpoints/create_secrets"
require_relative "../api/v1/endpoints/update_secrets"
require_relative "../api/v1/endpoints/delete_secrets"
require_relative "../api/v1/endpoints/decrypt_secrets"

RSpec.configure do |config|
  # rack_app = Module.new do
  #   def app
  #     @app ||= Rack::Builder.new do
  #       use Rack::Session::Cookie
  #
  #       run KeyService
  #     end
  #   end
  # end

  # config.include rack_app, type: :request

  config.color = true

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

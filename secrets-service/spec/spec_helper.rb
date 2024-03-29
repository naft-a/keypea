# frozen_string_literal: true

ENV["RACK_ENV"] = "test"

require "apia"
require "apia/rack"
require "dotenv"
require "openssl"
require "mongoid"
require "pry-remote"

Dotenv.load(".env.test")

require_relative "../config/mongoid"

require_relative "../lib/crypto"

require_relative "../models/part"
require_relative "../models/secret"
require_relative "../models/encryption_key"
require_relative "../models/password"

require_relative "../api/v1/base"
require_relative "../api/v1/endpoints/list_secrets"
require_relative "../api/v1/endpoints/create_secrets"
require_relative "../api/v1/endpoints/update_secrets"
require_relative "../api/v1/endpoints/delete_secrets"
require_relative "../api/v1/endpoints/decrypt_secrets_parts"
require_relative "../api/v1/endpoints/create_encryption_keys"

require_relative "./helpers/factory"
require_relative "./helpers/api_helpers"

RSpec.configure do |config|
  config.include Factory
  config.include APIHelpers, type: :api_endpoint

  config.before(:suite) do
    Mongoid.purge!
    Mongoid::Tasks::Database.create_indexes
  end

  config.color = true

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

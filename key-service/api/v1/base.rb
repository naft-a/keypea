# frozen_string_literal: true

require_relative "../authenticator"
require_relative "./endpoints/keys_create"
require_relative "./endpoints/keys_list"

module Api
  module V1
    class Base < Apia::API

      authenticator Authenticator

      scopes do
        add "keys", "Allows keys management"
      end

      routes do
        schema

        group :keys do
          get "/keys", endpoint: Endpoints::KeysList
          post "/keys", endpoint: Endpoints::KeysCreate
        end
      end

    end
  end
end

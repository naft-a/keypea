# frozen_string_literal: true

require "api/authenticator"
Dir["api/v1/endpoints/*.rb"].each { |file| require file }

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

# frozen_string_literal: true

require_relative "../authenticator"
require_relative "./endpoints/create_secrets"
require_relative "./endpoints/list_secrets"

module Api
  module V1
    class Base < Apia::API

      authenticator Authenticator

      scopes do
        add "records", "Allows keys management"
      end

      routes do
        schema

        group :records do
          get "/records", endpoint: Endpoints::ListSecrets
          post "/records", endpoint: Endpoints::CreateSecrets
        end
      end

    end
  end
end

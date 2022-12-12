# frozen_string_literal: true

require_relative "../authenticator"
require_relative "./objects/part"
require_relative "./objects/secret"
require_relative "./endpoints/create_secrets"
require_relative "./endpoints/list_secrets"
require_relative './endpoints/update_secrets'
require_relative "./endpoints/delete_secrets"
require_relative "./endpoints/decrypt_secrets"

module Api
  module V1
    class Base < Apia::API

      authenticator Authenticator

      scopes do
        add "records", "Allows keys management"
      end

      routes do
        schema

        group :secrets do
          get "/secrets", endpoint: Endpoints::ListSecrets
          post "/secrets", endpoint: Endpoints::CreateSecrets
          patch "/secrets/:secret_id", endpoint: Endpoints::UpdateSecrets
          delete "/secrets/:secret_id", endpoint: Endpoints::DeleteSecrets
          post "/secrets/:secret_id/decrypt", endpoint: Endpoints::DecryptSecrets
        end
      end

    end
  end
end

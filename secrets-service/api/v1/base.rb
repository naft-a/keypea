# frozen_string_literal: true

require_relative "../authenticator"
require_relative "./objects/part"
require_relative "./objects/secret"
require_relative "./errors/encryption_error"
require_relative "./errors/validation_error"
require_relative "./errors/password_blank_error"
require_relative "./argument_sets/part_arguments"
require_relative "./argument_sets/secret_arguments"
require_relative "./argument_sets/secret_lookup"
require_relative "./endpoints/create_secrets"
require_relative "./endpoints/list_secrets"
require_relative "./endpoints/update_secrets"
require_relative "./endpoints/delete_secrets"
require_relative "./endpoints/create_secrets_parts"
require_relative './endpoints/delete_secrets_parts'
require_relative "./endpoints/decrypt_secrets_parts"
require_relative "./endpoints/create_encryption_keys"

module Api
  module V1
    class Base < Apia::API

      authenticator Authenticator

      scopes do
        add "secrets", "Allows secrets management"
      end

      routes do
        schema

        group :secrets do
          get "/secrets", endpoint: Endpoints::ListSecrets
          post "/secrets", endpoint: Endpoints::CreateSecrets
          patch "/secrets/:secret", endpoint: Endpoints::UpdateSecrets
          delete "/secrets/:secret", endpoint: Endpoints::DeleteSecrets

          group :parts do
            post "/secrets/:secret/parts", endpoint: Endpoints::CreateSecretsParts
            delete "/secrets/:secret/parts/:part", endpoint: Endpoints::DeleteSecretsParts
            post "/secrets/:secret/parts/decrypt", endpoint: Endpoints::DecryptSecretsParts
          end
        end

        group :encryption_keys do
          post "/encryption_keys", endpoint: Endpoints::CreateEncryptionKeys
        end
      end

    end
  end
end

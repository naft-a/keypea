# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class CreateSecrets < Apia::Endpoint

        description "Creates a new secret for a given user"
        scope "secrets"

        argument :user_id, type: :string, required: true
        argument :properties, ArgumentSets::Secret, required: true

        field :secret, type: Objects::Secret, include: true

        potential_error "EncryptionKeyNotFound" do
          code :encryption_key_not_found
          description "Encryption Key for user_id is not found"
          http_status 422
        end

        potential_error Errors::EncryptionError
        potential_error Errors::ValidationError

        def call
          encryption_key = EncryptionKey.where(user_id: request.arguments[:user_id]).first
          raise_error "EncryptionKeyNotFound" if encryption_key.blank?

          secret = Secret.create!(
            user_id: request.arguments[:user_id],
            name: request.arguments[:properties][:name],
            description: request.arguments[:properties][:description],
            encryption_key: encryption_key,
            parts: []
          )

          response.add_field :secret, secret
        end

      end
    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class CreateEncryptionKeys < Apia::Endpoint

        description "Creates a new random key and encrypts it using the user's password"

        argument :user_id, type: :string, required: true
        argument :password, type: :string, required: true

        field :encryption_key_encrypted, type: :string

        potential_error "EncryptionKeyNotCreated" do
          code :encryption_key_not_created
          description "Key for user_id already exists"
          http_status 422
        end

        potential_error Errors::ValidationError

        def call
          raise_error Errors::PasswordBlankError if request.arguments[:password].blank?

          Password.set(request.arguments[:password])

          key = EncryptionKey.create!(user_id: request.arguments[:user_id])

          response.add_field :encryption_key_encrypted, key.value_encrypted
        rescue Mongo::Error::OperationFailure
          raise_error "EncryptionKeyNotCreated"
        end

      end
    end
  end
end

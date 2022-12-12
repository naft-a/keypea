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

        def call
          random_key = SecureRandom.hex(16)
          secret_key = request.arguments[:password]
          cipher = OpenSSL::Cipher::AES.new(256, :CBC)
          cipher.encrypt
          cipher.key = Digest::MD5.hexdigest(secret_key)
          encrypted_data = cipher.update(random_key.to_s) + cipher.final
          encrypted_data = Base64.urlsafe_encode64(encrypted_data, padding: false)

          EncryptionKey.create!(
            user_id: request.arguments[:user_id],
            value_encrypted: encrypted_data
          )

          response.add_field :encryption_key_encrypted, encrypted_data
        rescue Mongo::Error::OperationFailure
          raise_error "EncryptionKeyNotCreated"
        end

      end
    end
  end
end

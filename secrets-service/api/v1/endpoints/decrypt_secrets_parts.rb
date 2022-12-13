# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class DecryptSecretsParts < Apia::Endpoint

        description "Decrypt parts data from a secret"
        scope "secrets"

        argument :secret, type: ArgumentSets::SecretLookup, required: true
        argument :password, type: :string, required: true

        field :parts, type: [Objects::Part]

        def call
          secret = request.arguments[:secret].resolve
          secret.password = request.arguments[:password]

          decrypted_parts = secret.parts.map do |part|
            decipher = OpenSSL::Cipher::AES.new(256, :CBC)
            decipher.decrypt
            decipher.key = Digest::MD5.hexdigest(part.password)
            secret_key = decipher.update(Base64.urlsafe_decode64(part.encryption_key.value_encrypted)) + decipher.final

            decipher = OpenSSL::Cipher::AES.new(256, :CBC)
            decipher.decrypt
            decipher.key = secret_key
            key = decipher.update(Base64.urlsafe_decode64(part.key)) + decipher.final

            decipher = OpenSSL::Cipher::AES.new(256, :CBC)
            decipher.decrypt
            decipher.key = secret_key
            value = decipher.update(Base64.urlsafe_decode64(part.value)) + decipher.final

            part.key = key
            part.value = value
            part
          end

          response.add_field :parts, decrypted_parts
        end

      end
    end
  end
end

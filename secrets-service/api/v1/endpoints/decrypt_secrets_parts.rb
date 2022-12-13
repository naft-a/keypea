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

          Password.set(request.arguments[:password])

          decrypted_parts = secret.parts.map(&:decrypt)

          response.add_field :parts, decrypted_parts
        end

      end
    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class CreateSecretsParts < Apia::Endpoint

        description "Create a part in a secret"
        scope "secrets"

        argument :secret, type: ArgumentSets::SecretLookup, required: true
        argument :password, type: :string, required: true
        argument :key, type: :string, required: true
        argument :value, type: :string, required: true

        field :part, type: Objects::Part

        def call
          raise_error Errors::PasswordBlankError if request.arguments[:password].blank?

          Password.set(request.arguments[:password])

          secret = request.arguments[:secret].resolve
          part = Part.new(key: request.arguments[:key], value: request.arguments[:value])
          secret.parts << part
          secret.save!

          response.add_field :part, part
        end

      end
    end
  end
end

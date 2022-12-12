# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class UpdateSecrets < Apia::Endpoint

        description "Updates some data about a secret"
        scope "secrets"

        argument :secret, type: ArgumentSets::SecretLookup, required: true
        argument :properties, ArgumentSets::Secret do
          description "Details for the secret"
        end

        field :secret, type: Objects::Secret

        def call
          secret = request.arguments[:secret].resolve

          properties = request.arguments[:properties]
          properties = properties&.to_hash&.except(:parts) || {}
          secret.update!(**properties)

          response.add_field :secret, secret
        end

      end
    end
  end
end

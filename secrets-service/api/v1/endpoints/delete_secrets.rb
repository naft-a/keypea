# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class DeleteSecrets < Apia::Endpoint

        description "Deletes a secret"
        scope "secrets"

        argument :secret, type: ArgumentSets::SecretLookup, required: true

        field :secret, type: Objects::Secret

        def call
          secret = request.arguments[:secret].resolve
          secret.destroy!

          response.add_field :secret, secret
        end

      end
    end
  end
end

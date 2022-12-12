# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class DeleteSecrets < Apia::Endpoint

        description "Deletes a secret"
        scope "secrets"

        argument :secret_id, type: :string, required: true

        field :secret, type: Objects::Secret

        def call
          secret = Secret.find(request.arguments[:secret_id])
          secret.destroy! if secret.present?

          response.add_field :secret, secret
        end

      end
    end
  end
end

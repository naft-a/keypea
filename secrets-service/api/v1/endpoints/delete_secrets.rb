# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class DeleteSecrets < Apia::Endpoint

        description "Deletes a secret"
        scope "secrets"

        argument :secret_id, type: :string, required: true

        field :secret, type: Objects::Secret

        potential_error "SecretNotFound" do
          code :secret_not_found
          description "No secret was found matching any of the criteria provided in the arguments"
          http_status 404
        end

        def call
          secret = Secret.find(request.arguments[:secret_id])
          raise_error "SecretNotFound" if secret.blank?

          secret.destroy! if secret.present?

          response.add_field :secret, secret
        end

      end
    end
  end
end

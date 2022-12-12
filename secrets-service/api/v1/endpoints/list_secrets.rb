# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class ListSecrets < Apia::Endpoint

        description "List all encrypted secrets for a given user"
        scope "secrets"

        argument :user_id, type: :string, required: true

        field :secrets, type: [Objects::Secret] do
          description "All secrets of this user"
        end

        def call
          secrets = Secret.where(user_id: request.arguments[:user_id])
          response.add_field :secrets, secrets.to_a
        end

      end
    end
  end
end

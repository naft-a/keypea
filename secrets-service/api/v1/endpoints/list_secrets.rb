# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class ListSecrets < Apia::Endpoint

        description "List all encrypted secrets for a given user"
        scope "secrets"

        argument :user_id, type: :string, required: true
        field :secrets, type: :string

        def call
          user_id = request.arguments[:user_id]
          response.add_field :secrets, "here they're"
        end

      end
    end
  end
end

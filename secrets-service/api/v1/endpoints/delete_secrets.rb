# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class DeleteSecrets < Apia::Endpoint

        description "Deletes a secret"
        scope "secrets"

      end
    end
  end
end

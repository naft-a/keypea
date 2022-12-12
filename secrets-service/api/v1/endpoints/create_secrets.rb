# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class CreateSecrets < Apia::Endpoint

        description "Creates a new secret for a given user"
        scope "secrets"

        argument :user_id, type: :string, required: true
        argument :parts, type: [:string], required: true
        argument :properties, ArgumentSets::Secret, required: true

        field :secret, type: Objects::Secret, include: true do
          "The secret that was just created"
        end

        def call
          secret = Secret.new
          secret.user_id = request.arguments[:user_id]
          secret.name = request.arguments[:properties][:name]
          secret.description = request.arguments[:properties][:description]
          secret.encryption_key_encrypted = "test"
          secret.save

          response.add_field :secret, secret
        end

      end
    end
  end
end

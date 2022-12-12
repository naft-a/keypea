# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class CreateSecrets < Apia::Endpoint

        description "Creates a new secret for a given user"
        scope "secrets"

        argument :user_id, type: :string, required: true
        argument :parts, type: [:string], required: true
        field :secret, type: Objects::Secret, include: true do
          "The secret that was just created"
        end

        def call
          user_id = request.arguments[:user_id]
          secret = OpenStruct.new(
            id: "asdasd",
            user_id: user_id,
            name: "naaame",
            description: "fdjglksdfg",
            encryption_key_encrypted: "xaopjfrkmf",
            parts: [OpenStruct.new(key: "a", value: "xaaxxa"), OpenStruct.new(key: "b", value: "bahaha")],
            created_at: Time.now.utc,
            updated_at: Time.now.utc
          )

          response.add_field :secret, secret
        end

      end
    end
  end
end

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
          secret_id = request.arguments[:secret_id]

          secret = OpenStruct.new(
            id: secret_id,
            user_id: "asdasd",
            name: "naaame [DELETED]",
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

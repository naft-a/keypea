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
          array = [secret]

          response.add_field :secrets, array
        end

      end
    end
  end
end

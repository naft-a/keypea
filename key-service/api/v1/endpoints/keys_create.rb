# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class KeysCreate < Apia::Endpoint

        description "Creates a new keypair for a given user"
        scope "keys"

        argument :user_id, type: :string, required: true
        argument :keypair, type: :string, required: true
        field :keypair, type: :string

        def call
          keypair = request.arguments[:keypair]
          response.add_field :keypair, keypair
        end

      end
    end
  end
end

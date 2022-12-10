# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class KeysList < Apia::Endpoint

        description "List all keys for a given user"
        scope "keys"

        argument :user_id, type: :string, required: true
        field :keys, type: :string

        def call
          response.add_field :keys, "here they're"
        end

      end
    end
  end
end

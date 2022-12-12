# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class DecryptSecrets < Apia::Endpoint

        description "Decrypt parts data from a secret"
        scope "secrets"

        argument :secret_id, type: :string, required: true
        argument :password, type: :string, required: true

        field :parts, type: [Objects::Part]

        def call
          secret_id = request.arguments[:secret_id]
          password = request.arguments[:password]

          parts = [OpenStruct.new(key: password, value: secret_id), OpenStruct.new(key: password, value: secret_id)]
          response.add_field :parts, parts
        end

      end
    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class CreateSecrets < Apia::Endpoint

        description "Creates a new secret for a given user"
        scope "secrets"

        argument :user_id, type: :string, required: true
        argument :password, type: :string, required: true
        argument :properties, ArgumentSets::Secret, required: true

        field :secret, type: Objects::Secret, include: true

        def call
          secret = Secret.new(
            user_id: request.arguments[:user_id],
            name: request.arguments[:properties][:name],
            description: request.arguments[:properties][:description],
            password: request.arguments[:password],
            parts: request.arguments[:properties][:parts]&.map { |part_attrs| Part.new(**part_attrs) } || []
          )

          secret.save!
          secret.parts.map(&:save!)

          response.add_field :secret, secret
        end

      end
    end
  end
end

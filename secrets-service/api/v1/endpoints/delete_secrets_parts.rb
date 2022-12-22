# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class DeleteSecretsParts < Apia::Endpoint

        description "Deletes a part"
        scope "secrets"

        argument :secret, type: ArgumentSets::SecretLookup, required: true
        argument :part, type: :string, required: true

        field :part, type: Objects::Part

        potential_error "PartNotFound" do
          code :part_not_found
          description "No part was found matching any of the criteria provided in the arguments"
          http_status 404
        end

        def call
          secret = request.arguments[:secret].resolve
          part = secret.parts.find_by(id: request.arguments[:part])

          raise_error "PartNotFound" if part.nil?

          part.destroy!

          response.add_field :part, part
        end

      end
    end
  end
end
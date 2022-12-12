# frozen_string_literal: true

module Api
  module V1
    module ArgumentSets
      class SecretLookup < Apia::LookupArgumentSet

        name "Secret lookup"
        description "Provides for secrets to be looked up"

        argument :id, type: :string

        potential_error "SecretNotFound" do
          code :secret_not_found
          description "No secret was found matching any of the criteria provided in the arguments"
          http_status 404
        end

        resolver do |set, _request|
          secret = ::Secret.find(set[:id])
          raise_error "SecretNotFound" if secret.blank?

          secret
        end

      end
    end
  end
end
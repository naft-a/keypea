# frozen_string_literal: true

module Gateway
  module Services
    module SecretsService
      class Update < Gateway::Service

        # @param secret_id [String]
        # @param name [String]
        # @param description [String, nil]
        def initialize(secret_id:, name:, description: nil)
          @secret_id = secret_id
          @name = name
          @description = description || ""
        end

        # @raise [Gateway::Errors::ServiceErrors::RequestError]
        # @raise [Gateway::Errors::StructErrors::AttributeError]
        # @return [Secret]
        def call
          make_request(:secrets_api, :patch, "/secrets/:secret") do |request|
            request.arguments[:secret] = @secret_id
            request.arguments[:properties] = {
              name: @name,
              description: @description
            }

            response = request.perform
            Secret.from_api_hash(response.body["secret"])
          rescue APIClient::Errors::RequestError => e
            raise_service_error(e)
          rescue *[KeyError] => e
            raise_struct_error(e)
          end
        end

      end
    end
  end
end


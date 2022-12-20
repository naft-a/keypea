# frozen_string_literal: true

module Gateway
  module Services
    module SecretsService
      class Delete < Gateway::Service

        # @param secret_id [String]
        def initialize(secret_id:)
          @secret_id = secret_id
        end

        # @raise [Gateway::Errors::ServiceErrors::RequestError]
        # @raise [Gateway::Errors::StructErrors::AttributeError]
        # @return [Gateway::Structures::Secret]
        def call
          make_request(:secrets_api_host, :delete, "/secrets/:secret") do |request|
            request.arguments[:secret] = @secret_id

            response = request.perform
            Secret.from_api_hash(response.body["secret"])
          rescue APIClientErrors::RequestError => e
            raise_service_error(e)
          rescue *[KeyError] => e
            raise_struct_error(e)
          end
        end

      end
    end
  end
end
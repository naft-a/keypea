# frozen_string_literal: true

module Gateway
  module Services
    module SecretsService
      class DecryptSecretsParts < Gateway::Service

        # @param secret_id [String]
        # @param password [String]
        def initialize(secret_id:, password:)
          @secret_id = secret_id
          @password = password
        end

        # @raise [Gateway::Errors::ServiceErrors::RequestError]
        # @raise [Gateway::Errors::StructErrors::AttributeError]
        # @return [Array<Part>]
        def call
          make_request(:secrets_api_host, :post, "/secrets/:secret/parts/decrypt") do |request|
            request.arguments[:secret] = @secret_id
            request.arguments[:password] = @password

            response = request.perform
            response.body["parts"].map { |part| Part.from_api_hash(**part) }
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

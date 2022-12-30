# frozen_string_literal: true

module Gateway
  module Services
    module SecretsService
      class CreateSecretsParts < Gateway::Service

        # @param secret_id [String]
        # @param username [String]
        # @param password [String]
        # @param key [String]
        # @param value [String]
        def initialize(secret_id:, username:, password:, key:, value:)
          @secret_id = secret_id
          @username = username
          @password = password
          @key = key
          @value = value
        end

        # @raise [Gateway::Errors::ServiceErrors::RequestError]
        # @raise [Gateway::Errors::StructErrors::AttributeError]
        # @return [Gateway::Structures::Secret]
        def call
          AuthService::Authenticate.new(username: @username, password: @password).call

          make_request(:secrets_api_host, :post, "/secrets/:secret/parts") do |request|
            request.arguments[:secret] = @secret_id
            request.arguments[:password] = @password
            request.arguments[:key] = @key
            request.arguments[:value] = @value

            response = request.perform
            Part.from_api_hash(response.body["part"])
          end
        rescue APIClient::Errors::RequestError => e
          raise_service_error(e)
        rescue *[KeyError] => e
          raise_struct_error(e)
        end

      end
    end
  end
end

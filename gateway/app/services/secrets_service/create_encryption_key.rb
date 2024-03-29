# frozen_string_literal: true

module Gateway
  module Services
    module SecretsService
      class CreateEncryptionKey < Gateway::Service

        # @param user_id [String]
        # @param password [String]
        def initialize(user_id:, password:)
          @user_id = user_id
          @password = password
        end

        # @raise [Gateway::Errors::ServiceErrors::RequestError]
        # @raise [Gateway::Errors::StructErrors::AttributeError]
        # @return [Hash]
        def call
          make_request(:secrets_api, :post, "/encryption_keys") do |request|
            request.arguments[:user_id] = @user_id
            request.arguments[:password] = @password

            response = request.perform
            return {} unless response.status == 200

            JSON.parse(JSON[response.body], symbolize_names: true)
          end
        end

      end
    end
  end
end

# frozen_string_literal: true

module Gateway
  module Services
    module AuthService
      class Create < Gateway::Service

        # @param username [String]
        # @param password [String]
        def initialize(username:, password:)
          @username = username
          @password = password
        end

        # @raise [Gateway::Errors::ServiceErrors::RequestError]
        # @raise [Gateway::Errors::StructErrors::AttributeError]
        # @return [Gateway::Structures::User]
        def call
          make_request(:auth_api_host, :post, "/users") do |request|
            request.arguments[:username] = @username
            request.arguments[:password] = @password

            response = request.perform
            user = User.from_api_hash(response.body["user"])

            if response.status == 200
              SecretsService::CreateEncryptionKey.new(
                user_id: user.id,
                password: @password
              ).call
            end

            user
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

# frozen_string_literal: true

module Gateway
  module Services
    module AuthService
      class Authenticate < Gateway::Service

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
          make_request(:auth_api_host, :post, "/users/auth") do |request|
            request.arguments[:username] = @username
            request.arguments[:password] = @password

            response = request.perform
            User.from_api_hash(response.hash["user"])
          rescue ApiaClient::RequestError => e
            raise_service_error(e)
          rescue *[KeyError] => e
            raise_struct_error(e)
          end
        end

      end
    end
  end
end

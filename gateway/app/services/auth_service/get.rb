# frozen_string_literal: true

module Gateway
  module Services
    module AuthService
      class Get < Gateway::Service

        # @param user_id [String]
        def initialize(user_id:)
          @user_id = user_id
        end

        # @raise [Gateway::Errors::ServiceErrors::RequestError]
        # @raise [Gateway::Errors::StructErrors::AttributeError]
        # @return [Gateway::Structures::User]
        def call
          make_request(:auth_api_host, :get, "/users/:user") do |request|
            request.arguments[:user] = @user_id

            response = request.perform
            User.from_api_hash(response.body["user"])
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

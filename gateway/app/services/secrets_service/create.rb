# frozen_string_literal: true

module Gateway
  module Services
    module SecretsService
      class Create < Gateway::Service

        # @param user_id [String]
        # @param password [String]
        # @param name [String]
        # @param description [String]
        # @param parts [Array<>]
        def initialize(user_id:, password:, name:, description:, parts:)
          @user_id = user_id
          @password = password
          @name = name
          @description = description
          @parts = parts
        end

        # @raise [Gateway::Errors::ServiceErrors::RequestError]
        # @raise [Gateway::Errors::StructErrors::AttributeError]
        # @return [Gateway::Structures::Secret]
        def call
          make_request(:secrets_api_host, :post, "/secrets") do |request|
            request.arguments[:user_id] = @user_id
            request.arguments[:password] = @password
            request.arguments[:properties] = {
              name: @name,
              description: @description,
              parts: @parts
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

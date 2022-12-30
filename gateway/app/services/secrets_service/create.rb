# frozen_string_literal: true

module Gateway
  module Services
    module SecretsService
      class Create < Gateway::Service

        # @param user_id [String]
        # @param name [String]
        # @param description [String]
        def initialize(user_id:, name:, description:)
          @user_id = user_id
          @name = name
          @description = description
        end

        # @raise [Gateway::Errors::ServiceErrors::RequestError]
        # @raise [Gateway::Errors::StructErrors::AttributeError]
        # @return [Gateway::Structures::Secret]
        def call
          make_request(:secrets_api_host, :post, "/secrets") do |request|
            request.arguments[:user_id] = @user_id
            request.arguments[:properties] = {
              name: @name,
              description: @description
            }

            response = request.perform
            Secret.from_api_hash(response.body["secret"])
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

# frozen_string_literal: true

module Gateway
  module Services
    module SecretsService
      class List < Gateway::Service

        # @param user_id [String]
        def initialize(user_id:)
          @user_id = user_id
        end

        # @raise [Gateway::Errors::ServiceErrors::RequestError]
        # @raise [Gateway::Errors::StructErrors::AttributeError]
        # @return [Array<Secret>]
        def call
          make_request(:secrets_api_host, :get, "/secrets") do |request|
            request.arguments[:user_id] = @user_id

            response = request.perform
            response.body["secrets"].map { |secret| Secret.from_api_hash(secret) }
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

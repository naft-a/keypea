# frozen_string_literal: true

module Gateway
  module Services
    module SecretsService
      class DeleteSecretsParts < Gateway::Service

        # @param secret_id [String]
        # @param part_id [String]
        def initialize(secret_id:, part_id:)
          @secret_id = secret_id
          @part_id = part_id
        end

        # @raise [Gateway::Errors::ServiceErrors::RequestError]
        # @raise [Gateway::Errors::StructErrors::AttributeError]
        # @return [Gateway::Structures::Secret]
        def call
          make_request(:secrets_api, :delete, "/secrets/:secret/parts/:part") do |request|
            request.arguments[:secret] = @secret_id
            request.arguments[:part] = @part_id

            response = request.perform
            Part.from_api_hash(response.body["part"])
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

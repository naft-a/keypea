# frozen_string_literal: true

module Gateway
  module Actions
    module Secrets
      class Create < Gateway::Action

        params do
          required(:name).filled(:string)
          optional(:description).value(:string)
        end

        def handle(request, response)
          secret = Services::SecretsService::Create.new(
            user_id: Current.user_id,
            name: request.params[:name],
            description: request.params[:description],
          ).call

          response.body = secret.to_hash.to_json
        rescue ServiceErrors::RequestError => e
          handle_create_exception(e, response)
        end

        def handle_create_exception(exception, response)
          response.status = 422
          response.format = :json

          if exception.code.to_sym == :encryption_key_not_found
            error = {error: "Encryption key is missing"}
          else
            error = {error: exception.message}
          end

          response.body = error.to_json
        end

      end
    end
  end
end

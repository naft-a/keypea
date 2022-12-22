# frozen_string_literal: true

module Gateway
  module Actions
    module Secrets
      class Destroy < Gateway::Action

        params do
          required(:secret_id).filled(:string)
        end

        def handle(request, response)
          secret = Services::SecretsService::Delete.new(
            secret_id: request.params[:secret_id]
          ).call

          response.body = secret.to_hash.to_json
        rescue ServiceErrors::RequestError => e
          response.format = :json

          if e.code.to_sym == :secret_not_found
            response.status = 404
            response.body = {error: "Secret was not found"}.to_json
          else
            response.status = 422
            response.body = {error: "Something went wrong"}.to_json
          end
        end

      end
    end
  end
end

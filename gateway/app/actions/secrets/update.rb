# frozen_string_literal: true

module Gateway
  module Actions
    module Secrets
      class Update < Gateway::Action

        params do
          required(:secret_id).filled(:string)
          required(:name).filled(:string)
          optional(:description).value(:string)
        end

        def handle(request, response)
          secret = Services::SecretsService::Update.new(
            secret_id: request.params[:secret_id],
            name: request.params[:name],
            description: request.params[:description]
          ).call

          response.body = secret.to_hash.to_json
        rescue ServiceErrors::RequestError => e
          response.status = 422
          response.format = :json
          response.body = {error: e.message}.to_json
        end

      end
    end
  end
end

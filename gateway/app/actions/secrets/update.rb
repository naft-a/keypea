# frozen_string_literal: true

module Gateway
  module Actions
    module Secrets
      class Update < Gateway::Action

        params do
          required(:id).filled(:string)
          required(:name).filled(:string)
          optional(:description)
        end

        def handle(request, response)
          secret_id = request.params[:id]
          name = request.params[:name]
          description = request.params[:description] || ""

          update_service = Services::SecretsService::Update.new(
            secret_id: secret_id,
            name: name,
            description: description
          )

          secret = update_service.call
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

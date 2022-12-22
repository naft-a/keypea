# frozen_string_literal: true

module Gateway
  module Actions
    module Parts
      class Destroy < Gateway::Action

        params do
          required(:secret_id).filled(:string)
          required(:id).filled(:string)
        end

        def handle(request, response)
          part = Services::SecretsService::DeleteSecretsParts.new(
            secret_id: request.params[:secret_id],
            part_id: request.params[:id]
          ).call

          response.body = part.to_hash.to_json
        rescue ServiceErrors::RequestError => e
          response.status = 422
          response.format = :json
          response.body = {error: e.message}.to_json
        end

      end
    end
  end
end

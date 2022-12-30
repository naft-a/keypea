# frozen_string_literal: true

module Gateway
  module Actions
    module Parts
      class Create < Gateway::Action

        params do
          required(:secret_id).filled(:string)
          required(:password).filled(:string)
          required(:part).hash do
            required(:key).filled(:string)
            required(:value).filled(:string)
          end
        end

        def handle(request, response)
          part = Services::SecretsService::CreateSecretsParts.new(
            secret_id: request.params[:secret_id],
            username: Current.username,
            password: request.params[:password],
            key: request.params[:part][:key],
            value: request.params[:part][:value]
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

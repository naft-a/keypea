# frozen_string_literal: true

module Gateway
  module Actions
    module Parts
      class Decrypt < Gateway::Action

        params do
          required(:secret_id).filled(:string)
          required(:password).filled(:string)
        end

        def handle(request, response)
          secret_id = request.params[:secret_id]
          password = request.params[:password]

          parts = Services::SecretsService::DecryptSecretsParts.new(
            secret_id: secret_id,
            password: password
          ).call

          response.body = parts.map { |part| part.to_hash }.to_json
        rescue ServiceErrors::RequestError => e
          response.status = 422
          response.format = :json
          response.body = {error: e.message}.to_json
        end

      end
    end
  end
end

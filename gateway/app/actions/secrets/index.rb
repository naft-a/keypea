# frozen_string_literal: true

module Gateway
  module Actions
    module Secrets
      class Index < Gateway::Action

        def handle(request, response)
          secrets = Services::SecretsService::List.new(
            user_id: Current.user_id
          ).call

          secrets = secrets.map { |secret| secret.to_hash }.to_json

          response.body = secrets
        end

      end
    end
  end
end

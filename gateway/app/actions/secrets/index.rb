# frozen_string_literal: true

module Gateway
  module Actions
    module Secrets
      class Index < Gateway::Action

        def handle(request, response)
          list_service = Services::SecretsService::List.new(user_id: "123") #todo: change

          secrets = list_service.call
          secrets = secrets.map { |secret| secret.to_hash }.to_json

          response.body = secrets
        end

      end
    end
  end
end

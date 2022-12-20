# frozen_string_literal: true

module Gateway
  module Actions
    module Sessions
      class Create < Gateway::Action
        params do
          required(:username).filled(:string)
          required(:password).filled(:string)
        end

        def handle(request, response)
          username = request.params[:username]
          password = request.params[:password]

          create_service = Gateway::Services::AuthService::Create.new(username: username, password: password)
          user = create_service.call

          response.body = user.to_hash.to_json
        end

      end
    end
  end
end

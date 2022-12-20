# frozen_string_literal: true

module Gateway
  module Actions
    module Sessions
      class Authenticate < Gateway::Action

        params do
          required(:username).filled(:string)
          required(:password).filled(:string)
        end

        def handle(request, response)
          username = request.params[:username]
          password = request.params[:password]

          auth_service = Services::AuthService::Authenticate.new(username: username, password: password)
          user = auth_service.call

          response.body = user.to_hash.to_json
        rescue ServiceErrors::RequestError => e
          handle_authenticate_exception(e, response)
        end

        def handle_authenticate_exception(_exception, response)
          response.status = 401
          response.format = :json
          response.body = {error: "Invalid username or password"}.to_json
        end

      end
    end
  end
end

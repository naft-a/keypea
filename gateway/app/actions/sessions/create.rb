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

          create_service = Services::AuthService::Create.new(username: username, password: password)
          user = create_service.call

          response.body = user.to_hash.to_json
        rescue ServiceErrors::RequestError => e
          handle_create_exception(e, response)
        end

        private

        def handle_create_exception(exception, response)
          response.status = 422
          response.format = :json

          case exception.code.to_sym
          when :username_exists_error
            response.body = {error: "A user with this username already exists."}.to_json
          when :validation_error
            response.body = {error: "Something went wrong with."}.to_json
          end
        end

      end
    end
  end
end

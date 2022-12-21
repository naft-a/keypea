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

          user = Services::AuthService::Create.new(
            username: username,
            password: password
          ).call

          set_auth_token(request, user)

          user.access_token = Current.access_token
          response.body = user.to_hash.to_json
        rescue ServiceErrors::RequestError => e
          handle_create_exception(e, response)
        end

        private

        def handle_create_exception(exception, response)
          response.status = 422
          response.format = :json

          if exception.code.to_sym == :username_exists_error
            error = {error: "A user with this username already exists"}
          else
            error = {error: "Something went wrong"}
          end

          response.body = error.to_json
        end

        def validate_access_token
          # noop
        end

      end
    end
  end
end

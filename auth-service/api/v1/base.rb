# frozen_string_literal: true

require_relative "../authenticator"
require_relative "./objects/user"
require_relative "./errors/validation_error"
require_relative "./errors/username_exists_error"
require_relative "./errors/username_password_mismatch_error"
require_relative "./argument_sets/user_lookup"
require_relative "./endpoints/get_user"
require_relative "./endpoints/create_users"
require_relative "./endpoints/auth_user"

module Api
  module V1
    class Base < Apia::API

      authenticator Authenticator

      scopes do
        add "users", "Allows users integration"
      end

      routes do
        schema

        group :users do
          get "/users/:user_id", endpoint: Endpoints::GetUser
          post "/users", endpoint: Endpoints::CreateUsers

          group :auth do
            post "/users/auth", endpoint: Endpoints::AuthUser
          end
        end
      end

    end
  end
end

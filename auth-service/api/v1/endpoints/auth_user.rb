# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class AuthUser < Apia::Endpoint

        description "Authenticates a user using username and password"
        scope "users"

        argument :username, type: :string, required: true
        argument :password, type: :string, required: true

        field :user, type: Objects::User

        potential_error Errors::UsernamePasswordMismatchError

        def call
          user = User.authenticate!(
            username: request.arguments[:username],
            password: request.arguments[:password]
          )

          raise_error Errors::UsernamePasswordMismatchError if user.blank?

          response.add_field :user, user
        end

      end
    end
  end
end

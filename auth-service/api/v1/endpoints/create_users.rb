# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class CreateUsers < Apia::Endpoint

        description "Creates a new user"
        scope "users"

        argument :username, type: :string, required: true
        argument :password, type: :string, required: true

        field :user, type: Objects::User

        potential_error Errors::ValidationError

        def call
          user = User.create!(
            username: request.arguments[:username],
            password: request.arguments[:password]
          )

          response.add_field :secrets, user
        end

      end
    end
  end
end

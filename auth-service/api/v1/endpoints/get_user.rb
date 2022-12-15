# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class GetUser < Apia::Endpoint

        description "Information about a given user"
        scope "users"

        argument :user, type: ArgumentSets::UserLookup, required: true

        field :user, type: Objects::User

        def call
          user = request.arguments[:user].resolve
          response.add_field :user, user
        end

      end
    end
  end
end

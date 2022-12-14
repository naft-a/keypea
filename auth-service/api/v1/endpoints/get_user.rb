# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class GetUser < Apia::Endpoint

        description "Information about a given user"
        scope "users"

        argument :user_id, type: ArgumentSets::UserLookup, required: true

        field :user, type: Objects::User

        def call
          user = request.arguments[:user_id].resolve
          response.add_field :user, user
        end

      end
    end
  end
end

# frozen_string_literal: true

require "api/v1/objects/time"

module Api
  module V1
    module Endpoints
      class GithubSignin < Apia::Endpoint

        description "Generate Github csrf token"
        field :csrf_token, type: :string
        scope "github"

        def call
          response.add_field :csrf_token, Rack::Csrf.csrf_token(request.env)
        end

      end
    end
  end
end

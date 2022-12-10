# frozen_string_literal: true

require "api/v1/objects/time"

module Api
  module V1
    module Endpoints
      class GithubCallback < Apia::Endpoint

        description "Returns hello world"
        field :name, type: :string
        scope "github"

        def call
          binding.pry_remote
          # response.add_field :name,
        end

      end
    end
  end
end

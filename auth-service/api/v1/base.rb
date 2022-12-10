# frozen_string_literal: true

require "api/authenticator"
Dir["api/v1/endpoints/*.rb"].each { |file| require file }

module Api
  module V1
    class Base < Apia::API

      authenticator Authenticator

      scopes do
        add "github", "Allows Github OAuth integration"
      end

      routes do
        schema

        group :github do
          get "auth/github/signin", endpoint: Endpoints::GithubSignin
          get "auth/github/callback", endpoint: Endpoints::GithubCallback
        end
      end

    end
  end
end

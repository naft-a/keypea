# frozen_string_literal: true

module Api
  class Authenticator < Apia::Authenticator

    type :bearer

    potential_error "InvalidToken" do
      code :invalid_token
      description "The token provided is invalid. In this example, you should provide 'example'."
      http_status 403

      field :given_token, type: :string
    end

    def call
      given_token = request.headers["authorization"]&.sub(/\ABearer /, "")

      if given_token == ENV["API_TOKEN"]
        request.identity = { name: "gateway", id: request.headers["host"] || nil }
      else
        raise_error "Api/Authenticator/InvalidToken", given_token: given_token.to_s
      end
    end

  end
end

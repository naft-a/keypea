# frozen_string_literal: true

require "jwt"

module Gateway
  module JSONWebToken

    SECRET_KEY = Hanami.app["settings"].hmac_secret

    class << self

      # Encode given payload
      #
      # @param payload [Hash]
      # @param expires_in [Time]
      # @return token [String]
      def encode(payload, expires_in: Time.now + 24.hours)
        payload[:exp] = expires_in.to_i
        JWT.encode(payload, SECRET_KEY, "HS256")
      end

      # Decode a jwt token
      #
      # @param token [String]
      # @return [Hash, FalseClass]
      def decode(token)
        decoded = JWT.decode(token, SECRET_KEY, true, {algorithm: "HS256"})
        JSON.parse(JSON[decoded.first], symbolize_names: true)
      rescue JWT::DecodeError
        false
      end

    end

  end
end

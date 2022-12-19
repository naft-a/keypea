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
      def encode(payload, expires_in: 24.hours.from_now)
        payload[:exp] = expires_in.to_i
        JWT.encode(payload, SECRET_KEY, "HS256")
      end

      # Decode a jwt token
      #
      # @param token [String]
      # @return [Hash, FalseClass]
      def decode(token)
        decoded = JWT.decode(token, SECRET_KEY, true, {algorithm: "HS256"})
        HashWithIndifferentAccess.new(decoded)
      rescue JWT::DecodeError
        false
      end

    end

  end
end

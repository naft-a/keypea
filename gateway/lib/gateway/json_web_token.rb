# frozen_string_literal: true

require "jwt"

module Gateway
  module JsonWebToken

    SECRET_KEY = settings.hmac_secret

    class << self

      # Encode given payload
      #
      # @param payload [Hash]
      # @param expires_in []
      def encode(payload, expires_in: 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY, "HS256")
      end

      def decode(token)
        decoded = JWT.decode(token, SECRET_KEY, true, {algorithm: "HS256"})
        HashWithIndifferentAccess.new(decoded)
      rescue JWT::DecodeError
        false
      end

    end
  end
end

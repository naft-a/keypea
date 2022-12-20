# frozen_string_literal: true

require "redis"

module Gateway
  module RedisClient

    REDIS_URL = Hanami.app["settings"].redis_url

    class << self

      def client
        @client ||= Redis.new(url: REDIS_URL)
      end

      def set(key, value)
        client.set(key, value)
      end

      def get(key)
        client.get(key)
      end

      def del(key)
        client.del(key)
      end

    end

  end
end

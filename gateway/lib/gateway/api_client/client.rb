# frozen_string_literal: true

require "net/http"

module Gateway
  module APIClient
    class Client

      def initialize(**options)
        @headers = options[:headers]
        @namespace = options[:namespace]
        @http = Net::HTTP.new(options[:host], options[:port])
        @http.use_ssl = options[:ssl]
        @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        @http.read_timeout = options[:http_read_timeout] || 60
        @http.open_timeout = options[:http_open_timeout] || 10
      end

      # @param method [Symbol]
      # @param path [String]
      # @return [Gateway::APIClient::RequestProxy]
      def create_request(method, path)
        RequestProxy.new(method, "#{@namespace}#{path}", @headers, @http)
      end

    end
  end
end

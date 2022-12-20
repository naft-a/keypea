# frozen_string_literal: true

require "active_support/inflector"

module Gateway
  module APIClient
    class RequestProxy

      attr_accessor :arguments

      # @param method [Symbol]
      # @param path [String]
      # @param headers [String]
      # #param client [Net::HTTP]
      def initialize(method, path, headers, client)
        @method = method || :get
        @path = path
        @headers = headers
        @client = client
        @arguments = {}
      end

      # @raise [Errors::TimeoutError]
      # @raise [Errors::ConnectionError]
      # Return [Gateway::APIClient::Response]
      def perform
        response = @client.request(request)
        Response.new(response).handle
      rescue Timeout::Error => e
        raise Errors::TimeoutError, e.message
      rescue Net::HTTPServerException, StandardError => e
        raise Errors::ConnectionError, e.message
      end

      private

      attr_reader :method, :path, :headers

      def net_http_class
        ActiveSupport::Inflector.constantize("Net::HTTP::#{method.to_s.capitalize}")
      end

      def request
        @request = net_http_class.new(path_for_net_http)
        headers.each do |key, value|
          @request[key] = value
        end

        add_arguments_to_body unless skip_body_args?

        @request
      end

      def add_arguments_to_body
        @request["Content-Type"] = "application/json"
        @request.body = filtered_arguments.to_json
      end

      def filtered_arguments
        arguments.reject do |arg|
          path_params.include?(arg.inspect)
        end
      end

      def path_for_net_http
        new_path = path

        arguments.each do |key, value|
          new_path = new_path.gsub(key.inspect, value)
        end

        if method == :get && filtered_arguments.any?
          querystring = URI.encode_www_form(_arguments: filtered_arguments.to_json)
          "#{new_path}?#{querystring}"
        else
          new_path
        end
      end

      def path_params
        path.split("/").select { |part| part.start_with?(":") }
      end

      def skip_body_args?
        method == :get || method == :delete
      end

    end
  end
end
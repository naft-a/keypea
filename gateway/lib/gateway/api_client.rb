# frozen_string_literal: true

require "net/http"
require "active_support/inflector"

module Gateway
  module APIClient

    SETTINGS = Hanami.app["settings"]

    # @param host [Symbol]
    # @param method [Symbol]
    # @param path [String]
    # @yield request [RequestProxy]
    # @return request [RequestProxy]
    def make_request(host, method, path, &block)
      client = Client.new(
        host: SETTINGS.send(host),
        namespace: "/core/v1",
        ssl: true,
        headers: {
          "Authorization" => "Bearer example"
        }
      )

      @request = client.create_request(method, path)

      block.call(@request) if block_given?
    end

    class Client

      def initialize(**options)
        @headers = options[:headers]
        @namespace = options[:namespace]
        @http = Net::HTTP.new(options[:host], options[:ssl] ? 443 : 80)
        @http.use_ssl = options[:ssl]
        @http.read_timeout = options[:http_read_timeout] || 60
        @http.open_timeout = options[:http_open_timeout] || 10
      end

      def create_request(method, path)
        RequestProxy.new(method, "#{@namespace}#{path}", @headers, @http)
      end

    end

    class Response

      attr_accessor :http_response, :body, :headers, :status

      def initialize(http_response)
        @http_response = http_response
      end

      def handle
        if http_response["content-type"] =~ /application\/json/
          self.body = JSON.parse(http_response.body)
        end

        self.headers = http_response.to_hash
        self.status = http_response.code.to_i

        return self if status >= 200 && status < 300

        raise Errors::APIClientErrors::RequestError.new(status, body)
      end

    end

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

      def perform
        response = @client.request(request)
        Response.new(response).handle
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

        add_arguments_to_body unless method == :get || method == :delete

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

    end

  end
end

# frozen_string_literal: true

require "apia-client"

module Gateway
  module APIClient

    SETTINGS = Hanami.app["settings"]

    # @param host [Symbol]
    # @param method [Symbol]
    # @param path [String]
    # @yield request [ApiaClient::RequestProxy]
    # @return request [ApiaClient::RequestProxy]
    def make_request(host, method, path, &block)
      client = api_client(SETTINGS.send(host))
      client.load_schema

      @request = client.create_request(method, path)

      block.call(@request) if block_given?
    end

    private

    # @param host [String]
    def api_client(host)
      @api_client = ApiaClient::API.new(
        host,
        namespace: "/core/v1",
        headers: {
          "Authorization" => "Bearer example"
        }
      )
    end

  end
end

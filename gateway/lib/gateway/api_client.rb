# frozen_string_literal: true

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
        host: SETTINGS.send("#{host}_host"),
        port: SETTINGS.send("#{host}_port") || 443,
        namespace: "/core/v1",
        ssl: true,
        headers: {
          "Authorization" => "Bearer #{SETTINGS.send("#{host}_secret")}"
        }
      )

      @request = client.create_request(method, path)

      block.call(@request) if block_given?
    end

  end
end

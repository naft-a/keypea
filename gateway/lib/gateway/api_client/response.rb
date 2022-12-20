# frozen_string_literal: true

module Gateway
  module APIClient
    class Response

      attr_accessor :http_response, :body, :headers, :status

      def initialize(http_response)
        @http_response = http_response
      end

      # @raise [Net::HTTPServerException]
      # @raise [Errors::RequestError]
      # @return [Gateway::APIClient::Response]
      def handle
        if http_response["content-type"] =~ /application\/json/
          self.body = JSON.parse(http_response.body)
        end

        self.headers = http_response.to_hash
        self.status = http_response.code.to_i

        return self if status >= 200 && status < 300

        if body.blank?
          raise Net::HTTPServerException.new("#{status} #{http_response.message}", http_response)
        else
          raise Errors::RequestError.new(status, body)
        end
      end

    end
  end
end

# frozen_string_literal: true

module Gateway
  module APIClient
    module Errors

      class ConnectionError < StandardError
      end

      class TimeoutError < StandardError
      end

      class RequestError < StandardError

        attr_reader :status
        attr_reader :body

        def initialize(status, body)
          @status = status
          @body = body

          @error = @body["error"]
        end

        def to_s
          string = ["[#{@status}]"]
          if code && description
            string << "#{code}: #{description}"
          elsif code
            string << code
          else
            string << @body
          end
          string.join(' ')
        end

        def code
          return if @error.nil?

          @error["code"]
        end

        def description
          return if @error.nil?

          @error["description"]
        end

        def detail
          return if @error.nil?

          @error["detail"] || {}
        end

      end

    end
  end
end
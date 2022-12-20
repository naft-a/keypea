# frozen_string_literal: true

module Gateway
  module Errors

    class ServiceError < StandardError

      attr_reader :service
      attr_reader :details
      attr_reader :code

      def initialize(service, code, message, details)
        @service = service
        @code = code
        @details = details
        super(message)
      end

    end

    module ServiceErrors
      class RequestError < ServiceError
      end
    end

    module StructErrors
      class AttributeError < StandardError
      end
    end

  end
end

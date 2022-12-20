# frozen_string_literal: true

module Gateway
  class Service

    include Gateway::APIClient
    include Gateway::Structures
    include Gateway::Errors

    def call
      raise NotImplementedError
    end

    # @param error [Gateway::APIClient::Errors::RequestError]
    # @raise [Gateway::Errors::ServiceErrors::RequestError]
    def raise_service_error(error)
      details = {
        status: error.status,
        message: error.message,
        details: error.detail["details"]
      }

      raise ServiceErrors::RequestError.new(self, error.code, error.description, details)
    end

    # @param error [Exception]
    # @raise [Gateway::Errors::StructErrors::AttributeError]
    def raise_struct_error(error)
      raise StructErrors::AttributeError.new(error.message)
    end

  end
end

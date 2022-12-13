# frozen_string_literal: true

module Api
  module V1
    module Errors
      class EncryptionError < Apia::Error

        name "Encryption error"
        description "An encryption error occurred with the object being created"

        code :encryption_error
        http_status 422

        field :class_name, type: :string
        field :message, type: :string

        catch_exception OpenSSL::Cipher::CipherError do |fields, exception|
          fields[:class_name] = exception.class.to_s
          fields[:message] =  exception.message
        end

      end
    end
  end
end

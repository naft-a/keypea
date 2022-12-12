# frozen_string_literal: true

module Api
  module V1
    module Errors
      class EncryptionError < Apia::Error

        code :encryption_error
        http_status 422
        description "An encryption error occurred with the object being created"
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
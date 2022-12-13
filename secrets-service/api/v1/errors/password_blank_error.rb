# frozen_string_literal: true

module Api
  module V1
    module Errors
      class PasswordBlankError < Apia::Error

        name "Password validation error"
        description "An error occurred with the input provided - password cannot be blank"

        code :validation_error
        http_status 422

      end
    end
  end
end

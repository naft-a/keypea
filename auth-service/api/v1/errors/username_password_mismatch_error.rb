# frozen_string_literal: true

module Api
  module V1
    module Errors
      class UsernamePasswordMismatchError < Apia::Error

        name "Username and Password mismatch"
        description "An error occurred with the input provided - username does not match the password"

        code :username_password_mismatch_error
        http_status 401

      end
    end
  end
end

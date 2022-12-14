# frozen_string_literal: true

module Api
  module V1
    module Errors
      class UsernameExistsError < Apia::Error

        name "Username exists error"
        description "An error occurred with the input provided - username already exists"

        code :username_exists_error
        http_status 422

        field :details, [:string]

        catch_exception Mongo::Error::OperationFailure do |fields, exception|
          fields[:details] = exception.message
        end

      end
    end
  end
end

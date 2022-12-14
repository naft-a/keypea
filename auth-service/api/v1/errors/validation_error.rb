# frozen_string_literal: true

module Api
  module V1
    module Errors
      class ValidationError < Apia::Error

        name "Validation error"
        description "An error occurred with the input provided"

        code :validation_error
        http_status 422

        field :details, [:string]

        catch_exception Mongoid::Errors::Validations do |fields, exception|
          fields[:details] = exception.message.gsub("\n", " ").strip
        end

      end
    end
  end
end

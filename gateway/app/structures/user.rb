# frozen_string_literal: true

module Gateway
  module Structures
    class User < Gateway::Structure

      attr_accessor :id
      attr_accessor :username
      attr_accessor :access_token
      attr_accessor :created_at
      attr_accessor :updated_at

      # @raise [KeyError]
      # @param attributes [Hash]
      def initialize(**attributes)
        @id = attributes.fetch(:id)
        @username = attributes.fetch(:username)
        @access_token = nil
        @created_at = attributes.fetch(:created_at)
        @updated_at = attributes.fetch(:updated_at)
      end

    end
  end
end

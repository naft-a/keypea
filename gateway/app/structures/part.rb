# frozen_string_literal: true

module Gateway
  module Structures
    class Part < Gateway::Structure

      attr_accessor :id
      attr_accessor :key
      attr_accessor :value

      # @raise [KeyError]
      # @param attributes [Hash]
      def initialize(**attributes)
        @id = attributes.fetch(:id)
        @key = attributes.fetch(:key)
        @value = attributes.fetch(:value)
      end

    end
  end
end

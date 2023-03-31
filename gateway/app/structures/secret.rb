# frozen_string_literal: true

module Gateway
  module Structures
    class Secret < Gateway::Structure

      attr_accessor :id
      attr_accessor :user_id
      attr_accessor :name
      attr_accessor :description
      attr_accessor :parts
      attr_accessor :created_at
      attr_accessor :updated_at

      # @raise [KeyError]
      # @param attributes [Hash]
      def initialize(**attributes)
        @id = attributes.fetch(:id)
        @user_id = attributes.fetch(:user_id)
        @name = attributes.fetch(:name)
        @description = attributes.fetch(:description)
        @parts = attributes.fetch(:parts).map { |part_attributes| Part.new(**part_attributes) }
        @created_at = Time.at(attributes.fetch(:created_at))
        @updated_at = Time.at(attributes.fetch(:updated_at))
      end

    end
  end
end

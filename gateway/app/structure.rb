# frozen_string_literal: true

module Gateway
  class Structure

    class << self

      # @param hash [Hash<String, String>]
      # @return [Gateway::Structure]
      def from_api_hash(hash)
        attributes = JSON.parse(JSON[hash], symbolize_names: true)
        new(**attributes)
      end

    end

    attr_reader :attributes

    def initialize(**attributes)
    end

    def to_hash
      self.instance_variables.each_with_object({}) do |var, hash|
        value = self.instance_variable_get(var)

        if value.is_a?(Array)
          value = value.map { |item| item.to_hash }
        end

        hash[var[1..-1]&.to_sym] = value
      end
    end

  end
end

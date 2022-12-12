# frozen_string_literal: true

module Api
  module V1
    module Objects
      class Part < Apia::Object

        description "Represents a secret record with parts"

        field :key, type: :string
        field :value, type: :string

      end
    end
  end
end

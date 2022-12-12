# frozen_string_literal: true

module Api
  module V1
    module Objects
      class Part < Apia::Object

        description "Represents a part record"

        field :id, type: :string, backend: proc { |o| o.id.to_s }
        field :key, type: :string
        field :value, type: :string

      end
    end
  end
end

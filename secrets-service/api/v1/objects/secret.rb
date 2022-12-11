# frozen_string_literal: true

module Api
  module V1
    module Objects
      class Secret < Apia::Object

        description "Represents a secret record with parts"

        field :id
        field :name

      end
    end
  end
end

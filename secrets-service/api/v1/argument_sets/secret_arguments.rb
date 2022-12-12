# frozen_string_literal: true

module Api
  module V1
    module ArgumentSets
      class Secret < Apia::ArgumentSet

        argument :name, type: :string
        argument :description, type: :string
        argument :parts, type: [ArgumentSets::Part]

      end
    end
  end
end

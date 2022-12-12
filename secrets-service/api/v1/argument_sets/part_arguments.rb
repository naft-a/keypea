# frozen_string_literal: true

module Api
  module V1
    module ArgumentSets
      class Part < Apia::ArgumentSet

        argument :key, type: :string
        argument :value, type: :string

      end
    end
  end
end

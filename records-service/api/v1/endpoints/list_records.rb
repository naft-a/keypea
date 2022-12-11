# frozen_string_literal: true

module Api
  module V1
    module Endpoints
      class ListRecords < Apia::Endpoint

        description "List all encrypted records for a given user"
        scope "records"

        argument :user_id, type: :string, required: true
        field :records, type: :string

        def call
          user_id = request.arguments[:user_id]
          response.add_field :records, "here they're"
        end

      end
    end
  end
end

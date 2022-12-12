# frozen_string_literal: true

module Api
  module V1
    module Objects
      class Secret < Apia::Object

        description "Represents a secret record with parts"

        field :id, type: :string
        field :user_id, type: :string
        field :name, type: :string
        field :description, type: :string
        field :encryption_key_encrypted, type: :string
        field :parts, type: [Objects::Part]
        field :created_at, type: :unix_time, null: true
        field :updated_at, :unix_time, null: true

      end
    end
  end
end

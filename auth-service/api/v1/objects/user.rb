# frozen_string_literal: true

module Api
  module V1
    module Objects
      class User < Apia::Object

        description "Represents a user record"

        field :id, type: :string, backend: proc { |o| o.id.to_s }
        field :username, type: :string
        field :password, type: :string
        field :created_at, type: :unix_time, null: true
        field :updated_at, :unix_time, null: true

      end
    end
  end
end

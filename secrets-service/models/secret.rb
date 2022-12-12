# frozen_string_literal: true

class Secret
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: String
  field :name, type: String
  field :description, type: String
  field :encryption_key_encrypted, type: String

  has_many :parts
end

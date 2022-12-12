# frozen_string_literal: true

class Secret
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: String
  field :name, type: String
  field :description, type: String

  attr_accessor :password

  has_one :encryption_key
  has_many :parts

  validates :encryption_key, presence: true
end

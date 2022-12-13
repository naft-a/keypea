# frozen_string_literal: true

class Secret
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: String
  field :name, type: String
  field :description, type: String

  attr_accessor :password

  belongs_to :encryption_key
  has_many :parts

  with_options(presence: true) do
    validates :user_id, :name
  end
end

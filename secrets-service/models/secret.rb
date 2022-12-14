# frozen_string_literal: true

class Secret
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: String
  field :name, type: String
  field :description, type: String

  belongs_to :encryption_key
  has_many :parts, dependent: :destroy

  with_options(presence: true) do
    validates :user_id, :name
  end
end

# frozen_string_literal: true

class EncryptionKey
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: String
  field :value_encrypted, type: String

  has_many :secrets

  with_options(presence: true) do
    validates :user_id, :value_encrypted
  end

  index({ user_id: 1 }, { unique: true, name: "encryption_key_user_id_index" })
end

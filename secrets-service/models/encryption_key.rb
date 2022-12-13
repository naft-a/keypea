# frozen_string_literal: true

class EncryptionKey
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: String
  field :value_encrypted, type: String

  has_many :secrets

  validates :user_id, presence: true

  index({ user_id: 1 }, { unique: true, name: "encryption_key_user_id_index" })

  before_validation :set_encryption_key_value, if: -> { value_encrypted.blank? }

  def set_encryption_key_value
    self.value_encrypted = encrypt_encryption_key
  end

  def encrypt_encryption_key
    Crypto.encrypt(
      data: SecureRandom.hex(16),
      secret: Digest::MD5.hexdigest(Password.get)
    )
  end
end

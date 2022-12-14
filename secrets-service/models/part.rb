# frozen_string_literal: true

class Part
  include Mongoid::Document

  field :key, type: String
  field :value, type: String

  belongs_to :secret

  delegate :encryption_key, to: :secret

  before_save :encrypt

  # Encrypts key and value of this part
  #
  # @return [TrueClass]
  def encrypt
    secret_key = decrypted_secret_key

    self.key = Crypto.encrypt(data: key, secret: secret_key)
    self.value = Crypto.encrypt(data: value, secret: secret_key)

    true
  end

  # Decrypts the key and value of this part
  #
  # @return [Part]
  def decrypt
    secret_key = decrypted_secret_key

    self.key = Crypto.decrypt(encrypted_data: key, secret: secret_key)
    self.value = Crypto.decrypt(encrypted_data: value, secret: secret_key)

    self
  end

  private

  def decrypted_secret_key
    Crypto.decrypt(
      encrypted_data: encryption_key.value_encrypted,
      secret: Digest::MD5.hexdigest(Password.get)
    )
  end
end

# frozen_string_literal: true

class Part
  include Mongoid::Document

  field :key, type: String
  field :value, type: String

  belongs_to :secret

  delegate :password, to: :secret
  delegate :encryption_key, to: :secret

  before_save do
    # decrypt encryption_key
    decipher = OpenSSL::Cipher::AES.new(256, :CBC)
    decipher.decrypt
    decipher.key = Digest::MD5.hexdigest(password)
    secret_key = decipher.update(Base64.urlsafe_decode64(encryption_key.value_encrypted)) + decipher.final

    # encrypt key
    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt
    cipher.key = secret_key
    encrypted_key = cipher.update(key.to_s) + cipher.final
    self.key = Base64.urlsafe_encode64(encrypted_key, padding: false)

    # encrypt value
    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt
    cipher.key = secret_key
    encrypted_value = cipher.update(value.to_s) + cipher.final
    self.value = Base64.urlsafe_encode64(encrypted_value, padding: false)
  end
end

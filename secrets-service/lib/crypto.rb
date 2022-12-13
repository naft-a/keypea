# frozen_string_literal: true

module Crypto

  class << self
    def encrypt(data, secret)
      cipher = OpenSSL::Cipher::AES.new(256, :CBC)
      cipher.encrypt
      cipher.key = secret
      encrypted = cipher.update(data.to_s) + cipher.final
      Base64.urlsafe_encode64(encrypted, padding: false)
    end

    def decrypt(encrypted_data, secret)
      decipher = OpenSSL::Cipher::AES.new(256, :CBC)
      decipher.decrypt
      decipher.key = secret
      decipher.update(Base64.urlsafe_decode64(encrypted_data)) + decipher.final
    end
  end

end

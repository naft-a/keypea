# frozen_string_literal: true

class Part
  include Mongoid::Document

  field :key, type: String
  field :value, type: String

  belongs_to :secret

  delegate :password, to: :secret
  delegate :encryption_key, to: :secret

  before_save do
    binding.pry_remote

    # decrypt_encryption_key
    # encrypt_key
    # encrypt_value
  end

  def decrypt
  end

  def encrypt
  end
end

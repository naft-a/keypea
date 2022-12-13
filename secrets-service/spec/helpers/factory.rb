# frozen_string_literal: true

module Factory

  # Create dummy secret with a key attached to it
  #
  # @return [Mongoid::Document, nil]
  def create_secret_with_key_factory
    user_id = "test-#{rand(100)}"
    key = EncryptionKey.create!(
      user_id: user_id,
      value_encrypted: SecureRandom.hex(16)
    )

    Secret.create!(
      user_id: user_id,
      name: "test",
      description: "test",
      encryption_key: key,
      parts: []
    )
  end

  def create_encryption_key_for_user(user_id)
    user_id ||= "test-#{rand(100)}"
    EncryptionKey.create!(
      user_id: user_id,
      value_encrypted: SecureRandom.hex(16)
    )
  end

end

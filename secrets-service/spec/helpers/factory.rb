# frozen_string_literal: true

module Factory

  class EncryptionKeyFactory
    # Creates a secret record with a key attached to it
    #
    # @param user_id [String]
    # @return [Mongoid::Document, nil]
    def self.create!(user_id: nil)
      user_id ||= "test-#{rand(999)}"

      EncryptionKey.create!(
        user_id: user_id
      )
    end
  end

  class SecretFactory
    # Creates a secret record with a key attached to it
    #
    # @param user_id [String]
    # @param password [String]
    # @return [Mongoid::Document, nil]
    def self.create_with_key!(user_id: nil, key: nil , **options)
      Password.set("test")

      user_id ||= "test-#{rand(999)}"
      key ||= EncryptionKeyFactory.create!(user_id: user_id)

      secret = Secret.create!(
        user_id: user_id,
        name: user_id,
        description: "test secret for #{user_id}",
        encryption_key: key
      )

      if options[:with_parts]
        part = Part.new(key: "test-key", value: "test-value", secret: secret)
        part.save!
      end

      secret
    end
  end

end

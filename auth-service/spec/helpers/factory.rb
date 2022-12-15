# frozen_string_literal: true

module Factory

  class UserFactory
    # Creates a secret record with a key attached to it
    #
    # @param username [String]
    # @param password [String]
    # @return [Mongoid::Document, nil]
    def self.create!(username: nil, password: nil)
      username ||= "test-#{rand(999)}"

      User.create!(
        username: username,
        password: password
      )
    end
  end

end

# frozen_string_literal: true

class User

  include Mongoid::Document
  include Mongoid::Timestamps
  include BCrypt

  field :username, type: String
  field :password_hash, type: String

  index({ username: 1 }, { unique: true, name: "user_username_index" })

  with_options(presence: true) do
    validates :username, :password
  end

  # Creates a new BCrypt password from the user's password hash
  #
  # @return [BCrypt::Password]
  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  # Creates a new password hash and sets the password hash
  #
  # @param new_password [String]
  # @return [String]
  def password=(new_password)
    @password = BCrypt::Password.create(new_password)

    self.password_hash = @password
  end

  # Fetches user by username and compares the BCrypt password
  # with the password provided by the client
  #
  # @param username [String]
  # @param password [String]
  # @return [User, nil]
  def self.authenticate!(username:, password:)
    @user = self.find_by(username: username)

    if @user&.password == password
      @user
    else
      nil
    end
  end

end

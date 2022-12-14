# frozen_string_literal: true

class User

  include Mongoid::Document
  include Mongoid::Timestamps

  field :username, type: String
  field :password, type: String

  index({ username: 1 }, { unique: true, name: "user_username_index" })

  with_options(presence: true) do
    validates :username, :password
  end

  def self.authenticate!(username:, password:)
    self.find_by(username: username)
  end

end

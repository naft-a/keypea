# frozen_string_literal: true

class User

  include Mongoid::Document
  include Mongoid::Timestamps

  field :username, type: String
  field :password, type: String

  with_options(presence: true) do
    validates :username, :password
  end

  def self.authenticate!(username:, password:)
    raise NotImplementedError
  end

end

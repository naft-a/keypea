# frozen_string_literal: true

class Part
  include Mongoid::Document

  field :key, type: String
  field :value, type: String

  belongs_to :secret
end

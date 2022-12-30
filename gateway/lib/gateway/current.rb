# frozen_string_literal: true

require "active_support"
require "active_support/current_attributes"

module Gateway
  class Current < ActiveSupport::CurrentAttributes
    attribute :user_id
    attribute :username
    attribute :access_token
  end
end

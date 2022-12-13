# frozen_string_literal: true

# Dummy model that temporarily
# holds a user password value
class Password

  cattr_accessor :value

  class << self
    def get
      self.value
    end

    def set(value)
      self.value = value
    end
  end

end

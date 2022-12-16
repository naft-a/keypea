# frozen_string_literal: true

module Gateway
  class Settings < Hanami::Settings
    # Define your app settings here, for example:
    #
    # setting :my_flag, default: false, constructor: Types::Params::Bool

    setting :secret_key, constructor: Types::String
  end
end

# frozen_string_literal: true

module Gateway
  class Settings < Hanami::Settings
    # Define your app settings here, for example:
    #
    # setting :my_flag, default: false, constructor: Types::Params::Bool

    setting :hmac_secret, constructor: Types::String
    setting :auth_api_host, constructor: Types::String
    setting :auth_api_port, default: "443", constructor: Types::String
    setting :auth_api_secret, constructor: Types::String
    setting :secrets_api_host, constructor: Types::String
    setting :secrets_api_port, default: "443", constructor: Types::String
    setting :secrets_api_secret, constructor: Types::String
    setting :redis_url, constructor: Types::String
  end
end

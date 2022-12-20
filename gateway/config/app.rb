# frozen_string_literal: true

require "hanami"
require "pry-remote"
require "active_support/time"

module Gateway
  class App < Hanami::App
    config.middleware.use :body_parser, :json
  end
end

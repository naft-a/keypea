# frozen_string_literal: true

require "hanami"
require "pry-remote"
require "active_support/time"
require "rack/cors"

module Gateway
  class App < Hanami::App

    config.middleware.use Rack::Cors do
      allow do
        origins "https://frontend.localhost"
        resource "*", headers: :any, methods: :any
      end
    end

    config.middleware.use :body_parser, :json

  end
end

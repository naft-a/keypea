# frozen_string_literal: true

module Gateway
  class Routes < Hanami::Routes
    root { "Hello from Gateway" }

    scope :sessions do
      post "/", to: "sessions.create"
      post "/login", to: "sessions.authenticate"
      delete "/", to: "sessions.destroy"
    end

    scope :secrets do
      get "/", to: "secrets.index"
      post "/", to: "secrets.create"
      patch ":id", to: "secrets.update"
      delete ":id", to: "secrets.destroy"

      scope :parts do
        post "decrypt", to: "parts.decrypt"
      end
    end
  end
end

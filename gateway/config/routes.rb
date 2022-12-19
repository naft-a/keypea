# frozen_string_literal: true

module Gateway
  class Routes < Hanami::Routes
    root { "Hello from Hanami" }

    scope :sessions do
      post "/", to: "sessions.create"
      post "/login", to: "sessions.authenticate"
    end

    # scope :secrets do
    #   get "/", to: "secrets.index"
    #   post "/", to: "secrets.create"
    #   get "new", to: "secrets.new"
    #   get ":id", to: "secrets.show"
    #   patch ":id", to: "secrets.update"
    #   delete ":id", to: "secrets.destroy"
    # end
  end
end

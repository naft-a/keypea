# frozen_string_literal: true

module Gateway
  class Routes < Hanami::Routes
    root { "Hello from Gateway" }

    scope "sessions" do
      post "/", to: "sessions.signup"
      post "/login", to: "sessions.authenticate"
      delete "/logout", to: "sessions.logout"
    end

    get "/secrets", to: "secrets.index"
    post "/secrets", to: "secrets.create"
    patch "/secrets/:secret_id", to: "secrets.update"
    delete "/secrets/:secret_id", to: "secrets.destroy"

    post "/secrets/:secret_id/parts/decrypt", to: "parts.decrypt"
    post "/secrets/:secret_id/parts/", to: "parts.create"
    delete "/secrets/:secret_id/parts/:part_id", to: "parts.destroy"

  end
end

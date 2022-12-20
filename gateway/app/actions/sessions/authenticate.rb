# frozen_string_literal: true

module Gateway
  module Actions
    module Sessions
      class Authenticate < Gateway::Action
        params do
          required(:username).filled(:string)
          required(:password).filled(:string)
        end

        def handle(request, response)
          username = request.params[:username]
          password = request.params[:password]

          response.body = {name: "name is #{username} | password is #{password}"}.to_json
        end

      end
    end
  end
end

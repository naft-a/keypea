# frozen_string_literal: true

module Gateway
  module Actions
    module Sessions
      class Authenticate < Gateway::Action

        def handle(request, response)
          name = request.params[:name]

          response.body = {name: "name is #{name}"}.to_json
        end

      end
    end
  end
end

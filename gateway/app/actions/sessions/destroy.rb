# frozen_string_literal: true

module Gateway
  module Actions
    module Sessions
      class Destroy < Gateway::Action

        def handle(request, response)
          token = request.env["HTTP_AUTHORIZATION"]&.sub(/\ABearer /, "")
          RedisClient.del(token)

          response.headers["Location"] = "/"
          response.status = 200
          response.body = nil
        end

        private

        def validate_access_token
          # noop
        end

      end
    end
  end
end

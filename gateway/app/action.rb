# auto_register: false
# frozen_string_literal: true

require "hanami/action"

module Gateway
  class Action < Hanami::Action

    before :validate_params

    private

    def validate_params(request, _response)
      halt 422, request.params.errors.to_json unless request.params.valid?
    end
  end
end

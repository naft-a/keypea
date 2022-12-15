# frozen_string_literal: true

module APIHelpers

  # Makes api call to the CreateSecretEndpoint and returns
  # a response with a new secret
  #
  # @yield json_body [Hash]
  # @return Apia::Response
  def make_api_call
    Base.test_endpoint(described_class) do |req|
      req.headers["Authorization"] = "Bearer example"
      yield req.json_body
    end
  end

end

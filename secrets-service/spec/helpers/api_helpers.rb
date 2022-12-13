# frozen_string_literal: true

module APIHelpers

  # Makes api call to the CreateSecretEndpoint and returns
  # a response with a new secret
  #
  # @param payload [Hash]
  # @return Apia::Response
  def make_api_call_create_secret(payload)
    Base.test_endpoint(described_class) do |req|
      req.headers["Authorization"] = "Bearer example"
      req.json_body[:user_id] = payload[:user_id]
      req.json_body[:password] = payload[:password]
      req.json_body[:properties] = payload[:properties]
    end
  end

end

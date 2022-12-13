# frozen_string_literal: true

require "spec_helper"

include Api::V1

# TODO: create records and test the response
describe Endpoints::ListSecrets, type: :api_endpoint do
  it "receives a 200 response" do
    response = Base.test_endpoint(described_class) do |req|
      req.headers["Authorization"] = "Bearer example"
      req.json_body[:user_id] = "test"
      req.json_body[:keypair] = "test"
    end

    expect(response.status).to eq 200
  end
end

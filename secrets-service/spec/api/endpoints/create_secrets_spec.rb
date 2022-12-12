# frozen_string_literal: true

require "spec_helper"

include Api::V1

describe Endpoints::CreateSecrets do
  it "receives a 200 response" do
    response = Base.test_endpoint(described_class) do |req|
      req.headers["Authorization"] = "Bearer example"
      req.json_body[:user_id] = "asd"
      req.json_body[:parts] = ["a", "b"]
    end

    expect(response.status).to eq 200
  end
end

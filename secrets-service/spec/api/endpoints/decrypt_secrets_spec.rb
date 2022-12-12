# frozen_string_literal: true

require "spec_helper"

include Api::V1

describe Endpoints::DecryptSecrets do
  it "receives a 200 response" do
    response = Base.test_endpoint(described_class) do |req|
      req.headers["Authorization"] = "Bearer example"
      req.json_body[:secret_id] = "asd"
      req.json_body[:password] = "aaaaaa"
    end

    expect(response.status).to eq 200
  end
end

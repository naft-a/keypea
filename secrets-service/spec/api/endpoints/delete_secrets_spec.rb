# frozen_string_literal: true

require "spec_helper"

include Api::V1

describe Endpoints::DeleteSecrets do
  let(:secret_id) do
    user_id = "test-#{rand(100)}"

    Base.test_endpoint(Endpoints::CreateEncryptionKeys) do |req|
      req.headers["Authorization"] = "Bearer example"
      req.json_body[:user_id] = user_id
      req.json_body[:password] = "test"
    end

    response = Base.test_endpoint(Endpoints::CreateSecrets) do |req|
      req.headers["Authorization"] = "Bearer example"
      req.json_body[:user_id] = user_id
      req.json_body[:password] = "test"
      req.json_body[:properties] = {name: "new", description: "desc"}
    end

    response.body[:secret][:id]
  end

  describe "success" do
    it "receives a 200 response" do
      # response = Base.test_endpoint(described_class) do |req|
      #   req.headers["Authorization"] = "Bearer example"
      # end
      #
      # expect(response.status).to eq 200
    end
  end
end

# frozen_string_literal: true

require "spec_helper"

include Api::V1

describe Endpoints::DeleteSecrets, type: :api_endpoint do
  let!(:secret) { create_secret_with_key_factory }

  describe "success" do
    it "responds with 200" do
      response = Base.test_endpoint(described_class) do |req|
        req.headers["Authorization"] = "Bearer example"
        req.json_body[:secret] = {id: secret.id.to_s}
      end

      expect(response.status).to eq 200
    end
  end

  describe "failure" do
    it "responds with 404 if secret doesn't exist" do
      response = Base.test_endpoint(described_class) do |req|
        req.headers["Authorization"] = "Bearer example"
        req.json_body[:secret] = {id: "blank"}
      end

      expect(response.status).to eq 404
    end
  end
end

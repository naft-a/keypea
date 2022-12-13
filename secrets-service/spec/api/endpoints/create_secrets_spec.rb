# frozen_string_literal: true

require "spec_helper"

include Api::V1

describe Endpoints::CreateSecrets do
  let(:secret) do
    {
      user_id: "test",
      password: "test",
      properties: {
        name: "new",
        description: "a real one",
        parts: [
          {
            key: "wooo",
            value: "ssh-rsa"
          }
        ]
      }
    }
  end

  def create_secret(payload)
    Base.test_endpoint(described_class) do |req|
      req.headers["Authorization"] = "Bearer example"
      req.json_body[:user_id] = payload[:user_id]
      req.json_body[:password] = payload[:password]
      req.json_body[:properties] = payload[:properties]
    end
  end

  describe "success" do
    before do
      # create an encryption key
      Base.test_endpoint(Endpoints::CreateEncryptionKeys) do |req|
        req.headers["Authorization"] = "Bearer example"
        req.json_body[:user_id] = secret[:user_id]
        req.json_body[:password] = secret[:password]
      end
    end

    it "receives a 200 response" do
      response = create_secret(secret)

      expect(response.status).to eq 200
    end

    it "creates a new secret" do
      response = create_secret(secret)

      expect(response.body).to include :secret
      expect(response.body[:secret]).to include :id
    end

    it "encrypts parts" do
      response = create_secret(secret)
      key = response.body[:secret][:parts].first[:key]
      value = response.body[:secret][:parts].first[:value]

      expect(key).to_not eq secret[:properties][:parts].first[:key]
      expect(value).to_not eq secret[:properties][:parts].first[:key]
    end
  end

  describe "failure" do
    it "raises exception when encryption key for user is missing" do
      response = create_secret({user_id: "what", password: "what", properties: {}})

      expect(response.status).to eq 422
    end
  end
end

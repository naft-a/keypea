# frozen_string_literal: true

require "spec_helper"

include Api::V1

describe Endpoints::CreateSecrets, type: :api_endpoint do
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

  # todo: create encryption key without api call and test endpoint responses
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
      response = make_api_call do |json_body|
        json_body[:user_id] = secret[:user_id]
        json_body[:password] = secret[:password]
        json_body[:properties] = secret[:properties]
      end

      expect(response.status).to eq 200
    end

    it "creates a new secret" do
      response = make_api_call do |json_body|
        json_body[:user_id] = secret[:user_id]
        json_body[:password] = secret[:password]
        json_body[:properties] = secret[:properties]
      end

      expect(response.body).to include :secret
      expect(response.body[:secret]).to include :id
    end

    it "encrypts parts" do
      response = make_api_call do |json_body|
        json_body[:user_id] = secret[:user_id]
        json_body[:password] = secret[:password]
        json_body[:properties] = secret[:properties]
      end

      key = response.body[:secret][:parts].first[:key]
      value = response.body[:secret][:parts].first[:value]

      expect(key).to_not eq secret[:properties][:parts].first[:key]
      expect(value).to_not eq secret[:properties][:parts].first[:key]
    end
  end

  describe "failure" do
    it "raises exception when encryption key for user is missing" do
      response = make_api_call do |json_body|
        json_body[:user_id] = "what" # nonexistent user (one without an encryption key)
        json_body[:password] = "what"
        json_body[:properties] = {}
      end

      expect(response.status).to eq 422
    end

    it "raises exception when password key for user is missing" do
      response = make_api_call do |json_body|
        json_body[:user_id] = secret[:user_id]
        json_body[:password] = ""
        json_body[:properties] = {}
      end

      expect(response.status).to eq 422
    end
  end
end

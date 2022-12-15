# frozen_string_literal: true

require "spec_helper"

include Api::V1

# TODO: create records and test the response
describe Endpoints::ListSecrets, type: :api_endpoint do
  USER_ID = "test-list-user".freeze

  describe "success" do
    before(:context) do
      encryption_key = Factory::EncryptionKeyFactory.create!(user_id: USER_ID)

      5.times do
        Factory::SecretFactory.create_with_key!(user_id: USER_ID, key: encryption_key)
      end
    end

    it "receives a 200 response" do
      response = make_api_call do |json_body|
        json_body[:user_id] = USER_ID
      end

      expect(response.status).to eq 200
    end

    it "returns all 5 secrets for the user" do
      response = make_api_call do |json_body|
        json_body[:user_id] = USER_ID
      end

      expect(response.body[:secrets].size).to eq 5
    end

    it "returns no secrets if user is missing" do
      response = make_api_call do |json_body|
        json_body[:user_id] = "missing"
      end

      expect(response.body[:secrets].size).to eq 0
    end
  end
end

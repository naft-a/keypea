# frozen_string_literal: true

require "spec_helper"

include Api::V1

describe Endpoints::CreateEncryptionKeys, type: :api_endpoint do
  let(:first_user) do
    {
      user_id: "test",
      password: "test"
    }
  end

  let(:second_user) do
    {
      user_id: "test-2",
      password: "test-2"
    }
  end

  describe "success" do
    it "receives a 200 response" do
      response = make_api_call do |json_body|
        json_body[:user_id] = first_user[:user_id]
        json_body[:password] = first_user[:password]
      end

      expect(response.status).to eq 200
    end

    it "creates a new encryption key" do
      response = make_api_call do |json_body|
        json_body[:user_id] = second_user[:user_id]
        json_body[:password] = second_user[:password]
      end

      expect(response.status).to eq 200
      expect(response.body).to include :encryption_key_encrypted
    end
  end

  describe "failure" do
    it "returns an exception when there are duplicate encryption keys" do
      response = make_api_call do |json_body|
        json_body[:user_id] = second_user[:user_id]
        json_body[:password] = second_user[:password]
      end

      expect(response.status).to eq 422
    end

    it "returns an exception if user_id is missing" do
      response = make_api_call do |json_body|
        json_body[:user_id] = ""
        json_body[:password] = second_user[:password]
      end

      expect(response.status).to eq 422
    end

    it "returns an exception when password is missing" do
      response = make_api_call do |json_body|
        json_body[:user_id] = "random"
        json_body[:password] = ""
      end

      expect(response.status).to eq 422
    end
  end
end

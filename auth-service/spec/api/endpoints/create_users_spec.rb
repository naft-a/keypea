# frozen_string_literal: true

require "spec_helper"

include Api::V1

describe Endpoints::CreateUsers, type: :api_endpoint do
  let(:secret) do
    {
      username: "create-test",
      password: "create-test",
    }
  end

  describe "success" do
    it "receives a 200 response" do
      response = make_api_call do |json_body|
        json_body[:username] = secret[:username]
        json_body[:password] = secret[:password]
      end

      expect(response.status).to eq 200
    end

    it "creates a new user" do
      response = make_api_call do |json_body|
        json_body[:username] = "newuser"
        json_body[:password] = secret[:password]
      end

      expect(response.body).to include :user
      expect(response.body[:user]).to include :id
    end
  end

  describe "failure" do
    it "raises exception when username is missing" do
      response = make_api_call do |json_body|
        json_body[:username] = ""
        json_body[:password] = "what"
      end

      expect(response.status).to eq 422
    end

    it "raises exception when password is missing" do
      response = make_api_call do |json_body|
        json_body[:username] = secret[:username]
        json_body[:password] = ""
        json_body[:properties] = {}
      end

      expect(response.status).to eq 422
    end
  end
end

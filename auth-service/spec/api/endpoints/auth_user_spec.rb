# frozen_string_literal: true

require "spec_helper"

include Api::V1

describe Endpoints::AuthUser, type: :api_endpoint do
  describe "success" do
    before(:context) do
      @username = "auth-test"
      @password = "auth-test"

      Factory::UserFactory.create!(username: @username, password: @password)
    end

    it "receives a 200 response" do
      response = make_api_call do |json_body|
        json_body[:username] = @username
        json_body[:password] = @password
      end

      expect(response.status).to eq 200
    end

    it "authenticates a user" do
      response = make_api_call do |json_body|
        json_body[:username] = @username
        json_body[:password] = @password
      end

      expect(response.body).to include :user
      expect(response.body[:user]).to include :id
    end
  end

  describe "failure" do
    before(:context) do
      @username = "auth-test-2"
      @password = "auth-test-2"

      Factory::UserFactory.create!(username: @username, password: @password)
    end

    it "returns an exception when password does not match" do
      response = make_api_call do |json_body|
        json_body[:username] = @username
        json_body[:password] = "what"
      end

      expect(response.status).to eq 422
    end

    it "returns an exception when username does not match" do
      response = make_api_call do |json_body|
        json_body[:username] = "what"
        json_body[:password] = @password
      end

      expect(response.status).to eq 422
    end
  end
end

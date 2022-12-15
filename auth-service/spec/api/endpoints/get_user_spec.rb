# frozen_string_literal: true

require "spec_helper"

include Api::V1

describe Endpoints::GetUser, type: :api_endpoint do
  let!(:user) { Factory::UserFactory.create! }

  describe "success" do
    it "receives a 200 response" do
      response = make_api_call do |json_body|
        json_body[:user] = {id: user.id.to_s}
      end

      expect(response.status).to eq 200
    end

    it "gets a user" do
      response = make_api_call do |json_body|
        json_body[:user] = {id: user.id.to_s}
      end

      expect(response.body).to include :user
      expect(response.body[:user]).to include :id
    end
  end

  describe "failure" do
    it "returns an exception when user not found" do
      response = make_api_call do |json_body|
        json_body[:user] = {id: "notfound"}
      end

      expect(response.status).to eq 404
    end
  end
end

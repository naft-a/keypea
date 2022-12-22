# frozen_string_literal: true

require "spec_helper"

include Api::V1

describe Endpoints::CreateSecretsParts, type: :api_endpoint do
  let!(:secret) { Factory::SecretFactory.create_with_key! }
  let(:arguments) do
    {
      password: "test",
      key: "new-key",
      value: "new-value"
    }
  end

  describe "success" do
    it "receives a 200 response" do
      response = make_api_call do |params|
        params[:secret] = {id: secret.id.to_s}
        params[:password] = arguments[:password]
        params[:key] = arguments[:key]
        params[:value] = arguments[:value]
      end

      expect(response.status).to eq 200
    end


    it "creates a new part" do
      response = make_api_call do |params|
        params[:secret] = {id: secret.id.to_s}
        params[:password] = arguments[:password]
        params[:key] = arguments[:key]
        params[:value] = arguments[:value]
      end

      expect(response.body).to include :part
      expect(response.body[:part]).to include :id
      expect(secret.parts).to_not be_empty
    end
  end

  describe "failure" do
    it "raises exception when password key for user is missing" do
      response = make_api_call do |params|
        params[:secret] = {id: secret.id.to_s}
        params[:password] = ""
        params[:key] = arguments[:key]
        params[:value] = arguments[:value]
      end

      expect(response.status).to eq 422
    end
  end
end

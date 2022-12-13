# frozen_string_literal: true

require "spec_helper"

include Api::V1

describe Endpoints::UpdateSecrets, type: :api_endpoint do
  let!(:secret) { create_secret_with_key_factory }
  let(:payload) do
    {
      properties: {
        name: "test [updated]",
        description: "our first update"
      }
    }
  end

  describe "success" do
    it "receives a 200 response and updates props" do
      response = Base.test_endpoint(described_class) do |req|
        req.headers["Authorization"] = "Bearer example"
        req.json_body[:secret] = {
          id: secret.id.to_s
        }
        req.json_body[:properties] = payload[:properties]
      end

      expect(response.status).to eq 200
      expect(response.body[:secret][:name]).to eq payload[:properties][:name]
      expect(response.body[:secret][:description]).to eq payload[:properties][:description]
    end
  end

  describe "failure" do
    it "responds with 404 if secret doesn't exist" do
      response = Base.test_endpoint(described_class) do |req|
        req.headers["Authorization"] = "Bearer example"
        req.json_body[:secret] = {
          id: "doesntexist"
        }
        req.json_body[:properties] = payload[:properties]
      end

      expect(response.status).to eq 404
    end

    # it "responds with 422 if secret name is blank" do
    #   response = Base.test_endpoint(described_class) do |req|
    #     req.headers["Authorization"] = "Bearer example"
    #     req.json_body[:secret] = {
    #       id: secret.id.to_s
    #     }
    #     req.json_body[:properties] = {name: "", description: "here"}
    #   end
    #
    #   expect(response.status).to eq 422
    # end
  end

end

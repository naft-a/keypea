# frozen_string_literal: true

require "spec_helper"

include Api::V1

describe Endpoints::DeleteSecretsParts, type: :api_endpoint do
  let!(:secret) { Factory::SecretFactory.create_with_key!(with_parts: true) }
  let(:arguments) do
    {
      password: "test",
      key: "new-key",
      value: "new-value"
    }
  end

  describe "success" do
    it "deletes a part" do
      response = make_api_call do |params|
        params[:secret] = {id: secret.id.to_s}
        params[:part] = secret.parts.first.id.to_s
      end

      expect(response.status).to eq 200
      expect(secret.reload.parts).to be_empty
    end
  end

  describe "failure" do
    it "raises exception when part param is wrong" do
      response = make_api_call do |params|
        params[:secret] = {id: secret.id.to_s}
        params[:part] = ""
      end

      expect(response.status).to eq 404
    end
  end
end

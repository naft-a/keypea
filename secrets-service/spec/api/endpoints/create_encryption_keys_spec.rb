# frozen_string_literal: true

require "spec_helper"

include Api::V1

describe Endpoints::CreateEncryptionKeys do
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

  it "receives a 200 response" do
    response = Base.test_endpoint(described_class) do |req|
      req.headers["Authorization"] = "Bearer example"
      req.json_body[:user_id] = first_user[:user_id]
      req.json_body[:password] = first_user[:password]
    end

    expect(response.status).to eq 200
  end

  it "creates a new encryption key" do
    response = Base.test_endpoint(described_class) do |req|
      req.headers["Authorization"] = "Bearer example"
      req.json_body[:user_id] = second_user[:user_id]
      req.json_body[:password] = second_user[:password]
    end

    expect(response.status).to eq 200
    expect(response.body).to include :encryption_key_encrypted
  end


  it "doesn't create duplicate encryption keys" do
    response = Base.test_endpoint(described_class) do |req|
      req.headers["Authorization"] = "Bearer example"
      req.json_body[:user_id] = second_user[:user_id]
      req.json_body[:password] = second_user[:password]
    end

    expect(response.status).to eq 422
  end
end

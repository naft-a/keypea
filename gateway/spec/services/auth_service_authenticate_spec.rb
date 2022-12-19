# frozen_string_literal: true

include Gateway::Services::AuthService

RSpec.describe Authenticate, type: :service do

  describe ".new" do
    it "initializes the service" do
      service = described_class.new(username: "user", password: "password")
      expect(service).to be_instance_of Authenticate
    end
  end

  describe "#call" do
    include_context "api client" do
      let(:request_hash) { {username: "a", password: "b"} }
      let(:response_hash) do
        {
          "user" => {
            "id" => "user-id",
            "username" => "username",
            "password" => "password",
            "created_at" => 1671010507,
            "updated_at" => 1671010507
          }
        }
      end
    end

    it "returns a new user structure" do
      service_call = described_class.new(username: "a", password: "b").call
      expect(service_call).to be_instance_of Gateway::Structures::User
    end
  end

end

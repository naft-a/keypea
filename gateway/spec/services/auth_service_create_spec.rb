# frozen_string_literal: true

include Gateway::Services::AuthService

RSpec.describe Create, type: :service do

  describe ".new" do
    it "initializes the service" do
      service = described_class.new(username: "user", password: "password")
      expect(service).to be_instance_of Gateway::Services::AuthService::Create
    end
  end

  describe "#call" do
    include_context "api client" do
      let(:response_hash) do
        {
          "user" => {
            "id" => "user-id",
            "username" => "a",
            "password" => "b",
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

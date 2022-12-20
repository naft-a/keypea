# frozen_string_literal: true

include Gateway::Services::SecretsService

RSpec.describe DecryptSecretsParts, type: :service do

  describe ".new" do
    it "initializes the service" do
      service = described_class.new(secret_id: "id", password: "pwd")
      expect(service).to be_instance_of Gateway::Services::SecretsService::DecryptSecretsParts
    end
  end

  describe "#call" do
    include_context "api client" do
      let(:response_hash) do
        {
          "parts" => [
            {
              "id" => "63a067c94cfad10d8fbb5e5b",
              "key" => "decrypted",
              "value" => "value"
            },
            {
              "id" => "63a067c94cfad10d8fbb5e51",
              "key" => "decrypted2",
              "value" => "value2"
            }
          ]
        }
      end
    end

    it "returns a new secret structure" do
      service_call = described_class.new(secret_id: "id", password: "pwd").call
      expect(service_call).to be_instance_of Array
      expect(service_call.first).to be_instance_of Gateway::Structures::Part
    end
  end

end

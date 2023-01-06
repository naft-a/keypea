# frozen_string_literal: true

include Gateway::Services::SecretsService

RSpec.describe Create, type: :service do

  describe ".new" do
    it "initializes the service" do
      service = described_class.new(
        user_id: "123",
        name: "new-from-service",
        description: "ok?",
      )
      expect(service).to be_instance_of Gateway::Services::SecretsService::Create
    end
  end

  describe "#call" do
    include_context "api client" do
      let(:response_hash) do
        {
          "secret" => {
            "id" => "63a067c94cfad10d8fbb5e5a",
            "user_id" => "123",
            "name" => "new",
            "description" => "ok a real one",
            "parts" => [],
            "created_at" => 1671456713,
            "updated_at" => 1671456713
          }
        }
      end
    end

    it "returns a new secret structure" do
      service_call = described_class.new(
        user_id: "123",
        name: "new-from-service",
        description: "ok?"
      ).call
      expect(service_call).to be_instance_of Gateway::Structures::Secret
    end
  end

end

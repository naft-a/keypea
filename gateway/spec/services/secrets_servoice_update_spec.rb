# frozen_string_literal: true

include Gateway::Services::SecretsService

RSpec.describe Update, type: :service do

  describe ".new" do
    it "initializes the service" do
      service = described_class.new(secret_id: "id", name: "new-name", description: "desc")
      expect(service).to be_instance_of Gateway::Services::SecretsService::Update
    end
  end

  describe "#call" do
    include_context "api client" do
      let(:response_hash) do
        {
          "secret" => {
            "id" => "63a0a5",
            "user_id" => "123",
            "name" => "new-name",
            "description" => "desc",
            "parts" =>  [
              {
                "id" => "63a0a58cf4a46c2a7345ed50",
                "key" => "dLknDa87IWLgG6Gl7Nv7eg",
                "value" => "6ArSWJqwOZHC1OkhaW4-zQ"
              }
            ],
            "created_at" => 1671472524,
            "updated_at" => 1671472524
          }
        }
      end
    end

    it "returns a new secret structure" do
      service_call = described_class.new(secret_id: "63a0a5", name: "new-name", description: "desc").call
      expect(service_call).to be_instance_of Gateway::Structures::Secret
    end
  end

end

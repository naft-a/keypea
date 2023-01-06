# frozen_string_literal: true

include Gateway::Services::SecretsService

RSpec.describe CreateSecretsParts, type: :service do

  describe ".new" do
    it "initializes the service" do
      service = described_class.new(
        secret_id: "123",
        username: "test-name",
        password: "test-password",
        key: "part key",
        value: "part value"
      )
      expect(service).to be_instance_of Gateway::Services::SecretsService::CreateSecretsParts
    end
  end

  describe "#call" do
    include_context "api client" do
      let(:response_hash) do
        {
          "part" => {
            "id" => "63a067c94cfad10d8fbb5e5a",
            "key" => "encrypted-key",
            "value" => "encrypted-value"
          }
        }
      end
    end

    it "returns a new secret structure" do
      allow_any_instance_of(Gateway::Services::AuthService::Authenticate)
        .to receive(:call).and_return(Gateway::Structures::User)

      service_call = described_class.new(
        secret_id: "123",
        username: "test-name",
        password: "test-password",
        key: "part key",
        value: "part value"
      ).call
      expect(service_call).to be_instance_of Gateway::Structures::Part
    end
  end

end

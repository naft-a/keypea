# frozen_string_literal: true

include Gateway::Services::SecretsService

RSpec.describe CreateEncryptionKey, type: :service do

  describe ".new" do
    it "initializes the service" do
      service = described_class.new(user_id: "asd", password: "asd")
      expect(service).to be_instance_of Gateway::Services::SecretsService::CreateEncryptionKey
    end
  end

  describe "#call" do
    include_context "api client" do
      let(:response_hash) do
        {
          "encryption_key_encrypted" => "3NKEZ-oxYP8fJPRPyscXbGsTqSk73KLiQsIMxK8MyLwZUv7BHlKyFYTzYSgVbm4l"
        }
      end
    end

    it "returns hash" do
      service_call = described_class.new(user_id: "asd", password: "dsa").call
      expect(service_call).to be_instance_of Hash
    end
  end

end

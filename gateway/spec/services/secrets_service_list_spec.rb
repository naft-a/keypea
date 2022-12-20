# frozen_string_literal: true

include Gateway::Services::SecretsService

RSpec.describe List, type: :service do

  describe ".new" do
    it "initializes the service" do
      service = described_class.new(user_id: "id")
      expect(service).to be_instance_of Gateway::Services::SecretsService::List
    end
  end

  describe "#call" do
    include_context "api client" do
      let(:response_hash) do
        {
          "secrets" => [
            {
              "id" => "63a0a58cf4a46c2a7345ed4f",
              "user_id" => "123",
              "name" => "new",
              "description" => "ok a real one",
              "parts" =>  [
                {
                  "id" => "63a0a58cf4a46c2a7345ed50",
                  "key" => "dLknDa87IWLgG6Gl7Nv7eg",
                  "value" => "6ArSWJqwOZHC1OkhaW4-zQ"
                }
              ],
              "created_at" => 1671472524,
              "updated_at" => 1671472524
            },
            {
              "id" => "63a0df074cfad183eae9bb62",
              "user_id" => "123",
              "name" => "new",
              "description" => "ok a real one",
              "parts" => [
                {
                  "id" => "63a0df074cfad183eae9bb63",
                  "key" => "dLknDa87IWLgG6Gl7Nv7eg",
                  "value" => "6ArSWJqwOZHC1OkhaW4-zQ"
                }
              ],
              "created_at" => 1671487239,
              "updated_at" => 1671487239
            }
          ]
        }
      end
    end

    it "returns a new secret structure" do
      service_call = described_class.new(user_id: "123").call
      expect(service_call).to be_instance_of Array
      expect(service_call.first).to be_instance_of Gateway::Structures::Secret
    end
  end

end

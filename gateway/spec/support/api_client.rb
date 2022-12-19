# frozen_string_literal: true

RSpec.shared_context "api client" do
  before do
    response = Struct.new(:hash).new(response_hash)
    request = Struct.new(:arguments, :perform).new(request_hash, response)

    allow_any_instance_of(Gateway::APIClient).to receive(:make_request).and_yield(request)
  end
end

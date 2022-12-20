# frozen_string_literal: true

RSpec.shared_context "api client" do
  before do
    status = response_status rescue 200
    response = Struct.new(:status, :body).new(status, response_hash)
    request = Struct.new(:arguments, :perform).new({}, response)

    allow_any_instance_of(Gateway::APIClient).to receive(:make_request).and_yield(request)
  end
end

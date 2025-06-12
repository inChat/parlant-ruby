# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
RSpec.describe Parlant::Client do
  describe "#initialize" do
    it "creates a client with default configuration" do
      client = described_class.new
      expect(client).to be_a(Parlant::Client)
    end

    it "creates a client with custom configuration" do
      client = described_class.new(api_key: "custom-key", base_url: "https://custom-api.parlant.io")
      expect(client).to be_a(Parlant::Client)
    end
  end

  describe "resource access" do
    let(:client) { described_class.new }

    it "provides access to the agents resource" do
      expect(client.agents).to be_a(Parlant::Resources::Agent)
    end

    it "provides access to the customers resource" do
      expect(client.customers).to be_a(Parlant::Resources::Customer)
    end

    it "provides access to the sessions resource" do
      expect(client.sessions).to be_a(Parlant::Resources::Session)
    end

    it "provides access to the guidelines resource" do
      expect(client.guidelines).to be_a(Parlant::Resources::Guideline)
    end
  end

  describe "#request", :vcr do
    let(:client) { described_class.new(api_key: "test-api-key") }

    context "with unsuccessful response" do
      before do
        stub_request(:get, "https://api.parlant.io/agents")
          .to_return(status: 401, body: JSON.generate(message: "Unauthorized"))
      end

      it "raises an AuthenticationError for 401 responses" do
        expect { client.request(:get, "/agents") }.to raise_error(Parlant::AuthenticationError)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength

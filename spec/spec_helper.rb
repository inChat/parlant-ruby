# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  add_filter "/spec/"
  # Only run coverage in CI or when explicitly requested
  minimum_coverage 80
  enable_coverage :branch
  # Don't run coverage unless requested
  if ENV["CI"] || ENV["COVERAGE"]
    formatter SimpleCov::Formatter::HTMLFormatter
  else
    formatter SimpleCov::Formatter::SimpleFormatter
  end
end

require "parlant"
require "webmock/rspec"
require "vcr"

# Configure VCR
VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<API_KEY>") { ENV["PARLANT_API_KEY"] || "test-api-key" }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Clean up any test configuration
  config.before(:each) do
    Parlant.configuration = Parlant::Configuration.new
  end
end
